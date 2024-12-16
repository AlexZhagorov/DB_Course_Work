using System;
using System.Collections.Generic;
using DbmsApp.Controllers;
using Microsoft.EntityFrameworkCore;
using DbmsApp.Models;

namespace DbmsApp.Context;

public partial class PizzaPlaceContext : DbContext
{
    public PizzaPlaceContext()
    {
    }

    public PizzaPlaceContext(DbContextOptions<PizzaPlaceContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Address> Addresses { get; set; }

    public virtual DbSet<Coupon> Coupons { get; set; }

    public virtual DbSet<CouponsToOrder> CouponsToOrders { get; set; }
    
    public virtual DbSet<Good> Goods { get; set; }

    public virtual DbSet<GoodsToCoupon> GoodsToCoupons { get; set; }

    public virtual DbSet<GoodsToOrder> GoodsToOrders { get; set; }
    
    public virtual DbSet<ReadableGood> ReadableGoods { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<Product> Products { get; set; }


    public virtual DbSet<User> Users { get; set; }
    
    public virtual DbSet<Log> Logs { get; set; }
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
//#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server=(localdb)\\MSSQLLocalDB;Database=PizzaPlace;Trusted_Connection=True;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<ReadableGood>().ToView("ReadableGoods");
        modelBuilder.Entity<Address>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Addresse__3213E83F17FFF5A0");

            entity.HasIndex(e => e.UserId, "AddressesByUsers");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Adress)
                .HasMaxLength(200)
                .HasColumnName("address");
            entity.Property(e => e.Entrance)
                .HasMaxLength(10)
                .HasColumnName("entrance");
            entity.Property(e => e.Number)
                .HasMaxLength(10)
                .IsFixedLength()
                .HasColumnName("number");
            entity.Property(e => e.UserId).HasColumnName("userId");

            entity.HasOne(d => d.User).WithMany(p => p.Addresses)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__Addresses__userI__2B3F6F97");
        });

        modelBuilder.Entity<Log>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Logs__3213E83F9E37B947");
            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Logg).HasColumnName("log");
        });
        
        modelBuilder.Entity<Coupon>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Coupons__3213E83FB799233F");

            entity.HasIndex(e => e.Number, "CouponsByNumber");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.DateOfExpiration)
                .HasColumnType("date")
                .HasColumnName("dateOfExpiration");
            entity.Property(e => e.DateOfStart)
                .HasColumnType("date")
                .HasColumnName("dateOfStart");
            entity.Property(e => e.Number).HasColumnName("number");
            entity.Property(e => e.Price)
                .HasColumnType("money")
                .HasColumnName("price");
        });

        modelBuilder.Entity<CouponsToOrder>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable(tb => tb.HasTrigger("addToCouponCount"));

            entity.HasIndex(e => e.OrderId, "CouponsInOrders");

            entity.Property(e => e.Count)
                .HasDefaultValueSql("((1))")
                .HasColumnName("count");
            entity.Property(e => e.CouponId).HasColumnName("couponId");
            entity.Property(e => e.OrderId).HasColumnName("orderId");

            entity.HasOne(d => d.Coupon).WithMany()
                .HasForeignKey(d => d.CouponId)
                .HasConstraintName("FK__CouponsTo__coupo__36B12243");

            entity.HasOne(d => d.Order).WithMany()
                .HasForeignKey(d => d.OrderId)
                .HasConstraintName("FK__CouponsTo__order__35BCFE0A");
        });

        modelBuilder.Entity<Good>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Goods__3213E83FB362B16A");

            entity.ToTable(tb => tb.HasTrigger("checkSizeOfGood"));

            entity.HasIndex(e => e.ProductId, "GoodsByProduct");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Price)
                .HasDefaultValueSql("((1))")
                .HasColumnType("money")
                .HasColumnName("price");
            entity.Property(e => e.ProductId).HasColumnName("productId");
            entity.Property(e => e.Size)
                .HasMaxLength(3)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("size");

            entity.HasOne(d => d.Product).WithMany(p => p.Goods)
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK__Goods__productId__3A81B327");
        });

        modelBuilder.Entity<GoodsToCoupon>(entity =>
        {
            entity.HasNoKey();

            entity.HasIndex(e => e.CouponId, "GoodsInCoupons");

            entity.Property(e => e.Count)
                .HasDefaultValueSql("((1))")
                .HasColumnName("count");
            entity.Property(e => e.CouponId).HasColumnName("couponId");
            entity.Property(e => e.ProductId).HasColumnName("goodsId");

            entity.HasOne(d => d.Coupon).WithMany()
                .HasForeignKey(d => d.CouponId)
                .HasConstraintName("FK__GoodsToCo__coupo__4222D4EF");

            entity.HasOne(d => d.Product).WithMany()
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK__GoodsToCo__goods__412EB0B6");
        });

        modelBuilder.Entity<GoodsToOrder>(entity =>
        {
            entity
                .HasNoKey()
                .ToTable(tb =>
                {
                    tb.HasTrigger("addToGoodsCount");
                });

            entity.HasIndex(e => e.OrderId, "GoodsInOrders");

            entity.Property(e => e.Count)
                .HasDefaultValueSql("((1))")
                .HasColumnName("count");
            entity.Property(e => e.OrderId).HasColumnName("orderId");
            entity.Property(e => e.ProductId).HasColumnName("goodsId");

            entity.HasOne(d => d.Order).WithMany()
                .HasForeignKey(d => d.OrderId)
                .HasConstraintName("FK__GoodsToOr__order__3D5E1FD2");

            entity.HasOne(d => d.Product).WithMany()
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK__GoodsToOr__goods__3E52440B");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Orders__3213E83F51C8036A");

            entity.HasIndex(e => e.UserId, "OrdersByUsers");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.AddressId).HasColumnName("addressId");
            entity.Property(e => e.DateOfDelivery)
                .HasColumnType("datetime")
                .HasColumnName("dateOfDelivery");
            entity.Property(e => e.DateOfOrder)
                .HasColumnType("datetime")
                .HasColumnName("dateOfOrder");
            entity.Property(e => e.Price).HasColumnName("price");
            entity.Property(e => e.UserId).HasColumnName("userId");

            entity.HasOne(d => d.Address).WithMany(p => p.Orders)
                .HasForeignKey(d => d.AddressId)
                .HasConstraintName("FK__Orders__addressI__33D4B598");

            entity.HasOne(d => d.User).WithMany(p => p.Orders)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Orders__userId__31EC6D26");
        });
        modelBuilder.Entity<CatalogController.GoodDto>();   
        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Products__3213E83F22B9B203");

            entity.HasIndex(e => e.Type, "ProductsByType");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Ingredients)
                .HasMaxLength(100)
                .HasColumnName("ingredients");
            entity.Property(e => e.Name)
                .HasMaxLength(30)
                .IsFixedLength()
                .HasColumnName("name");
            entity.Property(e => e.Type)
                .HasMaxLength(14)
                .IsFixedLength()
                .HasColumnName("type");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Users__3213E83FA1797709");

            entity.HasIndex(e => e.Email, "UQ__Users__AB6E616451DBF337").IsUnique();

            entity.HasIndex(e => e.Phone, "UQ__Users__B43B145F37CB0EF4").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .IsFixedLength()
                .HasColumnName("email");
            entity.Property(e => e.FirstName)
                .HasMaxLength(20)
                .IsFixedLength()
                .HasColumnName("first_name");
            entity.Property(e => e.LastName)
                .HasMaxLength(20)
                .IsFixedLength()
                .HasColumnName("last_name");
            entity.Property(e => e.Password).HasColumnName("password");
            entity.Property(e => e.Phone)
                .HasMaxLength(9)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("phone");
            entity.Property(e => e.Role)
                .HasMaxLength(3)
                .IsUnicode(false)
                .HasDefaultValueSql("('usr')")
                .IsFixedLength()
                .HasColumnName("role");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
