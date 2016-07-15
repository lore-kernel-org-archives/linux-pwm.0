From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH v4 1/4] mfd: cros_ec: Add cros_ec_cmd_xfer_status helper
Date: Fri, 15 Jul 2016 16:28:41 -0700
Message-ID: <1468625324-41229-2-git-send-email-briannorris@chromium.org>
References: <1468625324-41229-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468625324-41229-1-git-send-email-briannorris@chromium.org>
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
v4:
 * return -EPROTO instead of custom (-EECRESULT - foo)
 * log msg->result in dev_dbg() (TBD!)

v3:
 * successfully spell success

v2:
 * no change
---
 drivers/platform/chrome/cros_ec_proto.c | 17 +++++++++++++++++
 include/linux/mfd/cros_ec.h             | 15 +++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index b6e161f71b26..6c084b266651 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -380,3 +380,20 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
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
+	if (ret < 0) {
+		dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
+	} else if (msg->result != EC_RES_SUCCESS) {
+		dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
+		return -EPROTO;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index 64184d27e3cd..d641a18abacb 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -226,6 +226,21 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
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
