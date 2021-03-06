package com.infotop.system.account.repository;

import org.springframework.stereotype.Component;

/**
 * GroupDao的扩展行为实现类.
 */
@Component
public class RoleDaoImpl implements RoleDaoCustom {

    private static final String QUERY_USER_BY_ROLEID = "select u from User u left join u.roleList r where r.id=?";

   /* @PersistenceContext
    private EntityManager em;*/

    @Override
    public void deleteWithReference(Long id) {
        //因為Group中沒有与User的关联，只能用笨办法，查询出拥有该权限组的用户, 并删除该用户的权限组.
      /*  Role role = em.find(Role.class, id);
        List<User> users = (List<User>) em.createQuery(QUERY_USER_BY_ROLEID).setParameter(1, id).getResultList();
        for (User u : users) {
            u.getRoleList().remove(role);
        }*/
        //        em.remove(role);
    }
   

}

