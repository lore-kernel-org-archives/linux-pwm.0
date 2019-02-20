From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v5 0/3] Add PM support to STM32 LP Timer drivers
Date: Wed, 20 Feb 2019 14:07:45 +0100
Message-ID: <1550668068-9661-1-git-send-email-fabrice.gasnier@st.com>
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
To: thierry.reding@gmail.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com, tduszyns@gmail.com, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, robh+dt@kernel.org, mcoquelin.stm32@gmail.com, u.kleine-koenig@pengutronix.de, fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

This patch series adds power management support for STM32 LP Timer:
- PWM driver
- Document the pinctrl states for sleep mode

It also adds device link between the PWM consumer and the PWM provider.
This allows proper sequencing for suspend/resume (e.g. user will likely
do a pwm_disable() before the PWM provider suspend executes), see [1].

[1] https://lkml.org/lkml/2019/2/5/770

---
Changes in v5:
- improve a warning message, fix a style issue.

Changes in v4:
- improve error handling when adding the PWM consumer device link.

Changes in v3:
- Move the device_link_add() call to of_pwm_get() as discussed with Uwe.

Changes in v2:
- Don't disable PWM channel in PWM provider: rather refuse to suspend
  and report an error as suggested by Uwe and Thierry.
- Add patch 3/3 to propose device link addition.
- No updates for STM32 LP Timer IIO driver. Patches can be send separately.

Fabrice Gasnier (3):
  dt-bindings: pwm-stm32-lp: document pinctrl sleep state
  pwm: stm32-lp: Add power management support
  pwm: core: add consumer device link

 .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |  9 ++--
 drivers/pwm/core.c                                 | 50 ++++++++++++++++++++--
 drivers/pwm/pwm-stm32-lp.c                         | 25 +++++++++++
 include/linux/pwm.h                                |  6 ++-
 4 files changed, 82 insertions(+), 8 deletions(-)

-- 
2.7.4
