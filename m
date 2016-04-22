From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 00/11] pwm: Add support for PWM Capture
Date: Fri, 22 Apr 2016 11:18:04 +0100
Message-ID: <1461320295-20414-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, maxime.coquelin@st.com, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

The first part of this set extends the current PWM API to allow external
code to request a PWM Capture.  Subsequent patches then make use of the
new API by providing a userspace offering via /sysfs.  The final part of
the set supplies PWM Capture functionality into the already existing STi
PWM driver.

This patch-set has been tested end to end via /sysfs.

v1 => v2:
  API change
  - Use a struct to carry the result back to the caller
  - Use 'struct pwm' to store device specific data
  - Make timeout configurable
  - Don't use clear_bit(), instead use raw bit logic
  - Propagate return value of platform_get_irq()
  - Don't cast to (void *)
  - Move to subsystem terminology (channels => devices)
  - Remove channel select feature
  - Enable Capture IP during capture

Lee Jones (11):
  pwm: Add PWM Capture support
  pwm: sti: Rename channel => device
  pwm: sysfs: Add PWM Capture support
  pwm: sti: Reorganise register names in preparation for new
    functionality
  pwm: sti: Only request clock rate when you need to
  pwm: sti: Supply PWM Capture register addresses and bit locations
  pwm: sti: Supply PWM Capture clock handling
  pwm: sti: Initialise PWM Capture device data
  pwm: sti: Add support for PWM Capture IRQs
  pwm: sti: Add PWM Capture call-back
  pwm: sti: Take the opportunity to conduct a little house keeping

 drivers/pwm/core.c    |  27 ++++
 drivers/pwm/pwm-sti.c | 411 +++++++++++++++++++++++++++++++++++++++++---------
 drivers/pwm/sysfs.c   |  17 +++
 include/linux/pwm.h   |  28 ++++
 4 files changed, 412 insertions(+), 71 deletions(-)

-- 
2.8.0
