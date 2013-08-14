Return-Path: <linux-arm-kernel-bounces+thierry.reding=gmail.com@lists.infradead.org>
From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 0/29] simplify use of devm_ioremap_resource
Date: Wed, 14 Aug 2013 11:11:04 +0200
Message-Id: <1376471493-22215-1-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+thierry.reding=gmail.com@lists.infradead.org
List-ID: <linux-pwm.vger.kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com, linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org

devm_ioremap_resource often uses the result of a call to
platform_get_resource as its last argument.  devm_ioremap_resource does
appropriate error handling on this argument, so error handling can be
removed from the call site.  To make the connection between the call to
platform_get_resource and the call to devm_ioremap_resource more clear, the
former is also moved down to be adjacent to the latter.

In many cases, this patch changes the specific error value that is
returned on failure of platform_get_resource.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression pdev,res,n,e,e1;
expression ret != 0;
identifier l;
@@

(
  res = platform_get_resource(pdev, IORESOURCE_MEM, n);
- if (res == NULL) { ... \(goto l;\|return ret;\) }
  e = devm_ioremap_resource(e1, res);
|
- res = platform_get_resource(pdev, IORESOURCE_MEM, n);
  ... when != res
- if (res == NULL) { ... \(goto l;\|return ret;\) }
  ... when != res
+ res = platform_get_resource(pdev, IORESOURCE_MEM, n);
  e = devm_ioremap_resource(e1, res);
)
// </smpl>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
