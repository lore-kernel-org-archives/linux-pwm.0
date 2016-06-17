From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 1/4] mfd: cros_ec: Add cros_ec_cmd_xfer_status helper
Date: Fri, 17 Jun 2016 12:58:12 -0700
Message-ID: <1466193495-95801-2-git-send-email-briannorris@chromium.org>
References: <1466193495-95801-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466193495-95801-1-git-send-email-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>
Cc: linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Brian Norris <briannorris@chromium.org>
List-Id: linux-pwm@vger.kernel.org

From: Tomeu Vizoso <tomeu.vizoso@collabora.com>

So that callers of cros_ec_cmd_xfer don't have to repeat boilerplate
code when checking for errors from the EC side.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
v3:
 * successfully spell success

v2:
 * no change
---
 drivers/platform/chrome/cros_ec_proto.c | 15 +++++++++++++++
 include/linux/mfd/cros_ec.h             | 18 ++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index b6e161f71b26..ecc544c728f0 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -380,3 +380,18 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 	return ret;
 }
 EXPORT_SYMBOL(cros_ec_cmd_xfer);
+
+int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
+			    struct cros_ec_command *msg)
+{
+	int ret;
+
+	ret = cros_ec_cmd_xfer(ec_dev, msg);
+	if (ret < 0)
+		dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
+	else if (msg->result != EC_RES_SUCCESS)
+		return -EECRESULT - msg->result;
+
+	return ret;
+}
+EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index 64184d27e3cd..7671704aa2d5 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -40,6 +40,9 @@
 #define EC_MAX_REQUEST_OVERHEAD		1
 #define EC_MAX_RESPONSE_OVERHEAD	2
 
+/* ec_command return value for non-success result from EC */
+#define EECRESULT 1000
+
 /*
  * Command interface between EC and AP, for LPC, I2C and SPI interfaces.
  */
@@ -226,6 +229,21 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 		     struct cros_ec_command *msg);
 
 /**
+ * cros_ec_cmd_xfer_status - Send a command to the ChromeOS EC
+ *
+ * This function is identical to cros_ec_cmd_xfer, except it returns success
+ * status only if both the command was transmitted successfully and the EC
+ * replied with success status. It's not necessary to check msg->result when
+ * using this function.
+ *
+ * @ec_dev: EC device
+ * @msg: Message to write
+ * @return: Num. of bytes transferred on success, <0 on failure
+ */
+int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
+			    struct cros_ec_command *msg);
+
+/**
  * cros_ec_remove - Remove a ChromeOS EC
  *
  * Call this to deregister a ChromeOS EC, then clean up any private data.
-- 
2.8.0.rc3.226.g39d4020
