import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "PackageServlet", value = "/packages")
public class PackageServlet extends HttpServlet {
    private PackageService packageService = new PackageService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String view = request.getParameter("view");
        List<EventPackage> packages = packageService.getAllPackages();

        request.setAttribute("packages", packages);

        if("admin".equals(view)) {
            request.getRequestDispatcher("admin-packages.jsp").forward(request, response);
        }else {
            request.getRequestDispatcher("Customer-packages.jsp").forward(request, response);
        }
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        EventPackage pkg = new EventPackage();
        pkg.setPackageId(request.getParameter("packageId"));
        pkg.setPackageName(request.getParameter("packageName"));
        pkg.setPackageDescription(request.getParameter("packageDescription"));
        pkg.setHoursCoverage(Integer.parseInt(request.getParameter("hoursCoverage")));
        pkg.setPhotographers(Integer.parseInt(request.getParameter("photographers")));
        pkg.setEdittingEnabled(request.getParameter("edittingEnabled") != null);
        pkg.setVideoIncluded(request.getParameter("videoIncluded") != null);

        switch (action) {
            case "add":
                pkg.setPackageId("PKG" + System.currentTimeMillis());
                packageService.addPackage(pkg);
                break;
            case "update":
                packageService.updatePackage(pkg);
                break;
            case "delete":
                packageService.deletePackage(pkg.getPackageId());
                break;
        }
        response.sendRedirect("packages?view=admin");
    }
}
