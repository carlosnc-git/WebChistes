/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import entities.Categoria;
import entities.Chiste;
import entities.Puntos;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jpautil.JPAUtil;
import model.ChistePuntuado;

/**
 *
 * @author Diurno
 */
public class Controller extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        RequestDispatcher dispatcher;
        String op;
        String sql;
        short rating;
        short idChiste;
        Puntos puntos;
        EntityTransaction transaction;
        Query query;
        List<Categoria> categorias = null;
        short idCategoria = -1;
        String apodo;
        String titulo;
        String contenidoChiste;
        Chiste chiste;
        Categoria cat;
        EntityManager em = (EntityManager) session.getAttribute("em");
        if (em == null) {
            em = JPAUtil.getEntityManagerFactory().createEntityManager();
            session.setAttribute("em", em);
        }
        op = request.getParameter("op");
        switch (op) {
            case "inicio":
                sql = "select c from Categoria c";
                query = em.createQuery(sql);
                categorias = query.getResultList();
                session.setAttribute("categorias", categorias);
                session.setAttribute("categoria", null);
                session.setAttribute("mejores",false);
                session.setAttribute("chistes", null);
                dispatcher = request.getRequestDispatcher("home.jsp");
                dispatcher.forward(request, response);
                break;
            case "dameCategoria":
                idCategoria = Short.parseShort(request.getParameter("comboCategoria"));
                if (idCategoria==-1){
                    session.setAttribute("categoria",null);
                }else {
                    session.setAttribute("categoria",em.find(Categoria.class, idCategoria));
                }
                session.setAttribute("chistes", null);
                session.setAttribute("mejores",false);
                dispatcher = request.getRequestDispatcher("home.jsp");
                dispatcher.forward(request, response);
                break;
            case "dameMejores":
                sql = "select p.idchiste from Puntos p group by p.idchiste order by avg(p.puntos) DESC";
                query = em.createQuery(sql);
                session.setAttribute("chistes",query.getResultList());
                session.setAttribute("mejores",true);
                session.setAttribute("categoria",null);
                dispatcher = request.getRequestDispatcher("home.jsp");
                dispatcher.forward(request, response);
                break;
            case "rating":
                rating = Short.parseShort(request.getParameter("rating"));
                idChiste = Short.parseShort(request.getParameter("chisteid"));
                puntos = new Puntos();
                puntos.setId(3);
                puntos.setIdchiste(em.find(Chiste.class, idChiste));
                puntos.setPuntos(new BigDecimal(rating));
                transaction = em.getTransaction();
                transaction.begin();
                em.persist(puntos);
                transaction.commit();
                em.getEntityManagerFactory().getCache().evictAll();
                if ((boolean) session.getAttribute("mejores")){
                    sql = "select p.idchiste from Puntos p group by p.idchiste order by avg(p.puntos) DESC";
                    query = em.createQuery(sql);
                    session.setAttribute("chistes",query.getResultList());
                } else {
                    cat = (Categoria) session.getAttribute("categoria");
                    session.setAttribute("categoria",em.find(Categoria.class, cat.getId()));
                }
                dispatcher = request.getRequestDispatcher("home.jsp");
                dispatcher.forward(request, response);
                break;
            case "nuevaCategoria":
                String nombre = (String) request.getParameter("nombreCategoria");
                cat = new Categoria();
                cat.setId((short)0);
                cat.setChisteList(new ArrayList<>());
                cat.setNombre(nombre);
                transaction = em.getTransaction();
                transaction.begin();
                em.persist(cat);
                transaction.commit();
                em.getEntityManagerFactory().getCache().evictAll();
                sql = "select c from Categoria c";
                query = em.createQuery(sql);
                categorias = query.getResultList();
                session.setAttribute("categorias", categorias);
                dispatcher = request.getRequestDispatcher("home.jsp");
                dispatcher.forward(request, response);
                break;
            case "nuevoChiste":
                apodo = (String) request.getParameter("apodoChiste");
                titulo = (String) request.getParameter("tituloChiste");
                cat = (Categoria) session.getAttribute("categoria");
                contenidoChiste = (String) request.getParameter("contenidoChiste");
                chiste = new Chiste((short)0);
                chiste.setAdopo(apodo);
                chiste.setDescripcion(contenidoChiste);
                chiste.setIdcategoria(cat);
                chiste.setPuntosList(new ArrayList<>());
                chiste.setTitulo(titulo);
                transaction = em.getTransaction();
                transaction.begin();
                em.persist(chiste);
                transaction.commit();
                em.getEntityManagerFactory().getCache().evictAll();
                cat = em.find(Categoria.class, cat.getId());
                session.setAttribute("categoria", cat);
                dispatcher = request.getRequestDispatcher("home.jsp");
                dispatcher.forward(request, response);
                break;
            default:
                break;
        }
    }
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
