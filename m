From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v2 0/3] Add PM support to STM32 Timer PWM
Date: Fri, 4 Oct 2019 14:53:50 +0200
Message-ID: <1570193633-6600-1-git-send-email-fabrice.gasnier@st.com>
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
To: thierry.reding@gmail.com, robh+dt@kernel.org, u.kleine-koenig@pengutronix.de
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: linux-pwm@vger.kernel.org

This patch series adds power management support for STM32 Timer PWM:
- Document the pinctrl sleep state for STM32 Timer PWM
- STM32 Timer PWM driver

---
Changes in v2:
Follow Uwe suggestions/remarks:
- Add a precursor patch to ease reviewing
- Use registers read instead of pwm_get_state
- Add a comment to mention registers content may be lost in low power mode

Fabrice Gasnier (3):
  dt-bindings: pwm-stm32: document pinctrl sleep state
  pwm: stm32: split breakinput apply routine to ease PM support
  pwm: stm32: add power management support

 .../devicetree/bindings/pwm/pwm-stm32.txt          |  8 +-
 drivers/pwm/pwm-stm32.c                            | 86 +++++++++++++++++-----
 2 files changed, 71 insertions(+), 23 deletions(-)

-- 
2.7.4
