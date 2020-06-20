From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
Subject: [RFC PATCH 09/10] MAINTAINERS: Add entry for Netronix embedded controller
Date: Sun, 21 Jun 2020 00:42:20 +0200
Message-ID: <20200620224222.1312520-8-j.neuschaefer@gmx.net>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200620224222.1312520-1-j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko.stuebner-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org>, Stephan Gerhold <stephan-3XONVrnlUWDR7s880joybQ@public.gmane.org>, Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>, Mark Brown <broonie@kernel.>
List-Id: linux-pwm@vger.kernel.org

Let's make sure I'll notice when there are patches for the NTXEC
drivers.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
=2D--
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 68f21d46614c4..d4333f7490f5d 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11850,6 +11850,17 @@ F:	include/net/netrom.h
 F:	include/uapi/linux/netrom.h
 F:	net/netrom/

+NETRONIX EMBEDDED CONTROLLER
+M:	Jonathan Neusch=C3=A4fer <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
+F:	Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.yaml
+F:	Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.yaml
+F:	drivers/mfd/ntxec.c
+F:	drivers/pwm/pwm-ntxec.c
+F:	drivers/rtc/rtc-ntxec.c
+F:	include/linux/mfd/ntxec.h
+
 NETRONOME ETHERNET DRIVERS
 M:	Jakub Kicinski <kuba-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
 L:	oss-drivers-wFxRvT7yatFl57MIdRCFDg@public.gmane.org
=2D-
2.27.0
