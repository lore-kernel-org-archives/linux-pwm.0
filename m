From: Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v2 01/17] platform/chrome: Add EC command msg
	wrapper
Date: Wed,  5 Feb 2020 10:59:55 -0800
Message-ID: <20200205190028.183069-2-pmalani@chromium.org>
References: <20200205190028.183069-1-pmalani@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20200205190028.183069-1-pmalani@chromium.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: linux-kernel@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Guenter Roeck <groeck@chromium.org>, Fabien Lahoudere <fabien.lahoudere@collabora.com>, Cheng-Yi Chiang <cychiang@chromium.org>, "open list:REAL TIME CLOCK RTC SUBSYSTEM" <linux-rtc@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee.jones@linaro.org>, Takashi Iwai <tiwai@suse.com>, Sebastian Reichel <sebastian.reichel@collabora.com>, Evan Green <evgreen@chromium.org>, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.c>
List-Id: linux-pwm@vger.kernel.org

Many callers of cros_ec_cmd_xfer_status() use a similar set up of
allocating and filling a message buffer and then copying any received
data to a target buffer.

Create a utility function cros_ec_cmd() that performs this setup so that
callers can use this function instead. Subsequent patches will convert
callers of cros_ec_cmd_xfer_status() to the new function instead.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Renamed function to cros_ec_cmd()
- Added result pointer parameter.
- Removed references to cros_ec_cmd_xfer() or cros_ec_cmd_xfer_status()
  from documentation.

 drivers/platform/chrome/cros_ec_proto.c     | 58 +++++++++++++++++++++
 include/linux/platform_data/cros_ec_proto.h |  4 ++
 2 files changed, 62 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 3cfa643f1d073d..b3d5368f596813 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -572,6 +572,64 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 }
 EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
 
+/**
+ * cros_ec_cmd() - Utility function to send commands to ChromeOS EC.
+ * @ec: EC device struct.
+ * @version: Command version number (often 0).
+ * @command: Command ID including offset.
+ * @outdata: Data to be sent to the EC.
+ * @outsize: Size of the &outdata buffer.
+ * @indata: Data to be received from the EC.
+ * @insize: Size of the &indata buffer.
+ * @result: Result of the transfer command.
+ *
+ * This function sends a command to the EC and also performs some of the common
+ * setup involved in doing so. This includes allocating and filling up a
+ * &struct cros_ec_command message buffer, and copying the received data to
+ * another buffer.
+ *
+ * Return: The number of bytes transferred on success or negative error code.
+ */
+int cros_ec_cmd(struct cros_ec_device *ec, u32 version, u32 command,
+		void *outdata, u32 outsize, void *indata,
+		u32 insize, u32 *result)
+{
+	struct cros_ec_command *msg;
+	int ret;
+
+	msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->version = version;
+	msg->command = command;
+	msg->outsize = outsize;
+	msg->insize = insize;
+
+	if (outdata && outsize > 0)
+		memcpy(msg->data, outdata, outsize);
+
+	ret = cros_ec_cmd_xfer(ec, msg);
+	if (result)
+		*result = msg->result;
+	if (ret < 0) {
+		dev_err(ec->dev, "Command xfer error (err:%d)\n", ret);
+		goto cleanup;
+	} else if (msg->result != EC_RES_SUCCESS) {
+		dev_dbg(ec->dev, "Command result (err: %d)\n", msg->result);
+		ret = -EPROTO;
+		goto cleanup;
+	}
+
+	if (insize)
+		memcpy(indata, msg->data, insize);
+
+cleanup:
+	kfree(msg);
+	return ret;
+}
+EXPORT_SYMBOL(cros_ec_cmd);
+
 static int get_next_event_xfer(struct cros_ec_device *ec_dev,
 			       struct cros_ec_command *msg,
 			       struct ec_response_get_next_event_v1 *event,
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index ba591477019180..54b9bbf9a07c0c 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -218,6 +218,10 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 			    struct cros_ec_command *msg);
 
+int cros_ec_cmd(struct cros_ec_device *ec_dev, u32 version, u32 command,
+		void *outdata, u32 outsize, void *indata, u32 insize,
+		u32 *result);
+
 int cros_ec_query_all(struct cros_ec_device *ec_dev);
 
 int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
-- 
2.25.0.341.g760bfbb309-goog
