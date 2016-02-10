From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/11] pwm: Add support for PWM Capture
Date: Wed, 10 Feb 2016 13:02:17 +0000
Message-ID: <1455109348-32767-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com
Cc: Lee Jones <lee.jones@linaro.org>, kernel@stlinux.com, maxime.coquelin@st.com
List-Id: linux-pwm@vger.kernel.org

The first part of this set extends the current PWM API to allow external
code to request a PWM Capture.  Subsequent patches then make use of the
new API by providing a userspace offering via /sysfs.  The final part of
the set supplies PWM Capture functionality into the already existing STi
PWM driver.

This patch-set has been tested end to end via /sysfs.

Lee Jones (11):
  pwm: Add PWM Capture support
  pwm: sysfs: Add PWM Capture support
  pwm: sti: Reorganise register names in preparation for new
    functionality
  pwm: sti: Only request clock rate when you need to
  pwm: sti: Supply PWM Capture register addresses and bit locations
  pwm: sti: Supply PWM Capture clock handling
  pwm: sti: Initialise PWM Capture channel data
  pwm: sti: Add support for PWM Capture IRQs
  pwm: sti: Add PWM Capture call-back
  pwm: sti: Enable PWM Capture
  pwm: sti: Take the opportunity to conduct a little house keeping

 drivers/pwm/core.c    |  26 ++++
 drivers/pwm/pwm-sti.c | 383 ++++++++++++++++++++++++++++++++++++++++++--------
 drivers/pwm/sysfs.c   |  28 ++++
 include/linux/pwm.h   |  13 ++
 4 files changed, 391 insertions(+), 59 deletions(-)

-- 
1.9.1
