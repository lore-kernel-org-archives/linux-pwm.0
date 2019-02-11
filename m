From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v2 0/3] Add PM support to STM32 LP Timer drivers
Date: Mon, 11 Feb 2019 17:11:59 +0100
Message-ID: <1549901522-15071-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org
Cc: u.kleine-koenig@pengutronix.de, tduszyns@gmail.com, mark.rutland@arm.com, alexandre.torgue@st.com, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-pwm@vger.kernel.org

This patch series adds power management support for STM32 LP Timer:
- PWM driver
- Document the pinctrl states for sleep mode

It also adds device link between the PWM consumer and the PWM provider.
This allows proper sequencing for suspend/resume (e.g. user will likely
do a pwm_disable() before the PWM provider suspend executes), see [1].

[1] https://lkml.org/lkml/2019/2/5/770

---
Changes in v2:
- Don't disable PWM channel in PWM provider: rather refuse to suspend
  and report an error as suggested by Uwe and Thierry.
- Add patch 3/3 to propose device link addition.
- No updates for STM32 LP Timer IIO driver. Patches can be send separately.

Fabrice Gasnier (3):
  dt-bindings: pwm-stm32-lp: document pinctrl sleep state
  pwm: stm32-lp: Add power management support
  pwm: core: add consumer device link

 .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |  9 +++++---
 drivers/pwm/core.c                                 | 13 +++++++++--
 drivers/pwm/pwm-stm32-lp.c                         | 25 ++++++++++++++++++++++
 3 files changed, 42 insertions(+), 5 deletions(-)

-- 
1.9.1
