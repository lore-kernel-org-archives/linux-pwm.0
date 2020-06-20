From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
Subject: [RFC PATCH 04/10] mfd: Add base driver for Netronix embedded controller
Date: Sun, 21 Jun 2020 00:42:15 +0200
Message-ID: <20200620224222.1312520-3-j.neuschaefer@gmx.net>
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

Third-party hardware documentation is available at
https://github.com/neuschaefer/linux/wiki/Netronix-MSP430-embedded-control=
ler

The EC supports interrupts, but the driver doesn't make use of them so
far.

Known problems:
- The reboot handler is installed in such a way that it directly calls
  into the i2c subsystem to send the reboot command to the EC. This
  means that the reboot handler may sleep, which is not allowed.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
=2D--
 drivers/mfd/Kconfig       |   7 ++
 drivers/mfd/Makefile      |   1 +
 drivers/mfd/ntxec.c       | 188 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/ntxec.h |  30 ++++++
 4 files changed, 226 insertions(+)
 create mode 100644 drivers/mfd/ntxec.c
 create mode 100644 include/linux/mfd/ntxec.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index a37d7d1713820..78410b928648e 100644
=2D-- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -978,6 +978,13 @@ config MFD_VIPERBOARD
 	  You need to select the mfd cell drivers separately.
 	  The drivers do not support all features the board exposes.

+config MFD_NTXEC
+	bool "Netronix Embedded Controller"
+	depends on I2C && OF
+	help
+	  Say yes here if you want to support the embedded controller of
+	  certain e-book readers designed by the ODM Netronix.
+
 config MFD_RETU
 	tristate "Nokia Retu and Tahvo multi-function device"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 9367a92f795a6..19d9391ed6f32 100644
=2D-- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -218,6 +218,7 @@ obj-$(CONFIG_MFD_INTEL_MSIC)	+=3D intel_msic.o
 obj-$(CONFIG_MFD_INTEL_PMC_BXT)	+=3D intel_pmc_bxt.o
 obj-$(CONFIG_MFD_PALMAS)	+=3D palmas.o
 obj-$(CONFIG_MFD_VIPERBOARD)    +=3D viperboard.o
+obj-$(CONFIG_MFD_NTXEC)		+=3D ntxec.o
 obj-$(CONFIG_MFD_RC5T583)	+=3D rc5t583.o rc5t583-irq.o
 obj-$(CONFIG_MFD_RK808)		+=3D rk808.o
 obj-$(CONFIG_MFD_RN5T618)	+=3D rn5t618.o
diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
new file mode 100644
index 0000000000000..82adea34ea746
=2D-- /dev/null
+++ b/drivers/mfd/ntxec.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright 2020 Jonathan Neusch=C3=A4fer
+//
+// MFD driver for the usually MSP430-based embedded controller used in ce=
rtain
+// Netronix ebook reader board designs
+
+#include <asm/unaligned.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/mfd/ntxec.h>
+#include <linux/of_platform.h>
+#include <linux/pm.h>
+#include <linux/reboot.h>
+#include <linux/types.h>
+
+
+#define NTXEC_VERSION		0x00
+#define NTXEC_POWEROFF		0x50
+#define NTXEC_POWERKEEP		0x70
+#define NTXEC_RESET		0x90
+
+
+/* Register access */
+
+int ntxec_read16(struct ntxec *ec, u8 addr)
+{
+	u8 request[1] =3D { addr };
+	u8 response[2];
+	int res;
+
+	struct i2c_msg msgs[] =3D {
+		{
+			.addr =3D ec->client->addr,
+			.flags =3D ec->client->flags,
+			.len =3D sizeof(request),
+			.buf =3D request
+		}, {
+			.addr =3D ec->client->addr,
+			.flags =3D ec->client->flags | I2C_M_RD,
+			.len =3D sizeof(response),
+			.buf =3D response
+		}
+	};
+
+	res =3D i2c_transfer(ec->client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (res < 0)
+		return res;
+	if (res !=3D ARRAY_SIZE(msgs))
+		return -EIO;
+
+	return get_unaligned_be16(response);
+}
+EXPORT_SYMBOL(ntxec_read16);
+
+int ntxec_write16(struct ntxec *ec, u8 addr, u16 value)
+{
+	u8 request[3] =3D { addr, };
+	int res;
+
+	put_unaligned_be16(value, request + 1);
+
+	res =3D i2c_transfer_buffer_flags(ec->client, request, sizeof(request),
+					ec->client->flags);
+	if (res < 0)
+		return res;
+
+	return 0;
+}
+EXPORT_SYMBOL(ntxec_write16);
+
+int ntxec_read8(struct ntxec *ec, u8 addr)
+{
+	int res =3D ntxec_read16(ec, addr);
+
+	if (res < 0)
+		return res;
+
+	return (res >> 8) & 0xff;
+}
+EXPORT_SYMBOL(ntxec_read8);
+
+int ntxec_write8(struct ntxec *ec, u8 addr, u8 value)
+{
+	return ntxec_write16(ec, addr, value << 8);
+}
+EXPORT_SYMBOL(ntxec_write8);
+
+
+/* Reboot/poweroff handling */
+
+static struct ntxec *poweroff_restart_instance;
+
+static void ntxec_poweroff(void)
+{
+	ntxec_write8(poweroff_restart_instance, NTXEC_POWEROFF, 0x01);
+	msleep(5000);
+}
+
+static int ntxec_restart(struct notifier_block *nb,
+		unsigned long action, void *data)
+{
+	/* FIXME: The I2C driver sleeps, but restart handlers may not sleep */
+	ntxec_write8(poweroff_restart_instance, NTXEC_RESET, 0xff);
+	/* TODO: delay? */
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ntxec_restart_handler =3D {
+	.notifier_call =3D ntxec_restart,
+	.priority =3D 128
+};
+
+
+/* Driver setup */
+
+static int ntxec_probe(struct i2c_client *client,
+			    const struct i2c_device_id *ids)
+{
+	struct ntxec *ec;
+	int res;
+
+	ec =3D devm_kmalloc(&client->dev, sizeof(*ec), GFP_KERNEL);
+	if (!ec)
+		return -ENOMEM;
+
+	ec->dev =3D &client->dev;
+	ec->client =3D client;
+
+	/* Determine the firmware version */
+	res =3D ntxec_read16(ec, NTXEC_VERSION);
+	if (res < 0) {
+		dev_dbg(ec->dev, "Failed to read firmware version number\n");
+		return res;
+	}
+	ec->version =3D res;
+
+	dev_info(ec->dev,
+		 "Netronix embedded controller version %04x detected.\n",
+		 ec->version);
+
+	/* For now, we don't support the new register layout. */
+	if (ntxec_has_new_layout(ec))
+		return -EOPNOTSUPP;
+
+	if (of_device_is_system_power_controller(ec->dev->of_node)) {
+		/*
+		 * Set the 'powerkeep' bit. This is necessary on some boards
+		 * in order to keep the system running.
+		 */
+		res =3D ntxec_write8(ec, NTXEC_POWERKEEP, 0x08);
+		if (res < 0)
+			return res;
+
+		/* Install poweroff handler */
+		WARN_ON(poweroff_restart_instance);
+		poweroff_restart_instance =3D ec;
+		if (pm_power_off !=3D NULL)
+			/* TODO: Refactor among all poweroff drivers */
+			dev_err(ec->dev, "pm_power_off already assigned\n");
+		else
+			pm_power_off =3D ntxec_poweroff;
+
+		/* Install board reset handler */
+		res =3D register_restart_handler(&ntxec_restart_handler);
+		if (res < 0)
+			dev_err(ec->dev,
+				"Failed to register restart handler: %d\n", res);
+	}
+
+	i2c_set_clientdata(client, ec);
+
+	return devm_of_platform_populate(ec->dev);
+}
+
+static const struct of_device_id of_ntxec_match_table[] =3D {
+	{ .compatible =3D "netronix,ntxec", },
+	{}
+};
+
+static struct i2c_driver ntxec_driver =3D {
+	.driver	=3D {
+		.name	=3D "ntxec",
+		.of_match_table =3D of_ntxec_match_table,
+	},
+	.probe		=3D ntxec_probe,
+};
+builtin_i2c_driver(ntxec_driver);
diff --git a/include/linux/mfd/ntxec.h b/include/linux/mfd/ntxec.h
new file mode 100644
index 0000000000000..9f9d6f2141751
=2D-- /dev/null
+++ b/include/linux/mfd/ntxec.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2020 Jonathan Neusch=C3=A4fer
+ *
+ * MFD access functions for the Netronix embedded controller.
+ */
+
+#ifndef NTXEC_H
+#define NTXEC_H
+
+#include <linux/types.h>
+
+struct ntxec {
+	struct device *dev;
+	struct i2c_client *client;
+	u16 version;
+	/* TODO: Add a mutex to protect actions consisting of multiple accesses?=
 */
+};
+
+static inline bool ntxec_has_new_layout(struct ntxec *ec)
+{
+	return ec->version =3D=3D 0xe916;
+}
+
+int ntxec_read16(struct ntxec *ec, u8 addr);
+int ntxec_write16(struct ntxec *ec, u8 addr, u16 value);
+int ntxec_read8(struct ntxec *ec, u8 addr);
+int ntxec_write8(struct ntxec *ec, u8 addr, u8 value);
+
+#endif
=2D-
2.27.0
