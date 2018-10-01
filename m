From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v2 2/2] pwm: send a uevent on the pwmchip device upon channel
 sysfs (un)export
Date: Mon, 1 Oct 2018 15:23:57 +0200
Message-ID: <1538400237-28766-3-git-send-email-fabrice.gasnier@st.com>
References: <1538400237-28766-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1538400237-28766-1-git-send-email-fabrice.gasnier@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com, gottfried.haider@gmail.com
Cc: stefan.wahren@i2se.com, linux-pwm@vger.kernel.org, gohai@sukzessiv.net, michal.vokac@ysoft.com, loic.pallardy@st.com, linux-kernel@vger.kernel.org, hsweeten@visionengravers.com, broonie@kernel.org, linux-rpi-kernel@lists.infradead.org, fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

This patch sends a uevent (KOBJ_CHANGE) on the pwmchipN device, everytime
a pwmX channel has been exported/unexported via sysfs.
This allows udev to implement rules on such events, like:

SUBSYSTEM=="pwm*", PROGRAM="/bin/sh -c '\
        chown -R root:gpio /sys/class/pwm && chmod -R 770 /sys/class/pwm;\
        chown -R root:gpio
/sys/devices/platform/soc/*.pwm/pwm/pwmchip* && chmod -R 770
/sys/devices/platform/soc/*.pwm/pwm/pwmchip*\
'"

This is a replacement patch for commit 7e5d1fd75c3d ("pwm: Set class for
exported channels in sysfs"), see [1].

basic testing:
$ udevadm monitor --environment &
$ echo 0 > /sys/class/pwm/pwmchip0/export
KERNEL[197.321736] change   /devices/.../pwm/pwmchip0 (pwm)
ACTION=change
DEVPATH=/devices/.../pwm/pwmchip0
EXPORT=pwm0
SEQNUM=2045
SUBSYSTEM=pwm

[1] https://lkml.org/lkml/2018/9/25/713

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Tested-by: Gottfried Haider <gottfried.haider@gmail.com>
---
 drivers/pwm/sysfs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 4726d43..ceb233d 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -249,6 +249,7 @@ static void pwm_export_release(struct device *child)
 static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
 {
 	struct pwm_export *export;
+	char *pwm_prop[2];
 	int ret;
 
 	if (test_and_set_bit(PWMF_EXPORTED, &pwm->flags))
@@ -276,6 +277,10 @@ static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
 		export = NULL;
 		return ret;
 	}
+	pwm_prop[0] = kasprintf(GFP_KERNEL, "EXPORT=pwm%u", pwm->hwpwm);
+	pwm_prop[1] = NULL;
+	kobject_uevent_env(&parent->kobj, KOBJ_CHANGE, pwm_prop);
+	kfree(pwm_prop[0]);
 
 	return 0;
 }
@@ -288,6 +293,7 @@ static int pwm_unexport_match(struct device *child, void *data)
 static int pwm_unexport_child(struct device *parent, struct pwm_device *pwm)
 {
 	struct device *child;
+	char *pwm_prop[2];
 
 	if (!test_and_clear_bit(PWMF_EXPORTED, &pwm->flags))
 		return -ENODEV;
@@ -296,6 +302,11 @@ static int pwm_unexport_child(struct device *parent, struct pwm_device *pwm)
 	if (!child)
 		return -ENODEV;
 
+	pwm_prop[0] = kasprintf(GFP_KERNEL, "UNEXPORT=pwm%u", pwm->hwpwm);
+	pwm_prop[1] = NULL;
+	kobject_uevent_env(&parent->kobj, KOBJ_CHANGE, pwm_prop);
+	kfree(pwm_prop[0]);
+
 	/* for device_find_child() */
 	put_device(child);
 	device_unregister(child);
-- 
1.9.1
