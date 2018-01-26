From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v2 0/8] Add support for PWM input capture on STM32
Date: Fri, 26 Jan 2018 16:11:31 +0100
Message-ID: <1516979499-3665-1-git-send-email-fabrice.gasnier@st.com>
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
To: lee.jones@linaro.org, thierry.reding@gmail.com, robh+dt@kernel.org, alexandre.torgue@st.com, benjamin.gaignard@linaro.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, benjamin.gaignard@st.com, linux-pwm@vger.kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

This series adds support for capture to stm32-pwm driver.
Capture is based on DMAs.
- First two patches are precursor patches
- Subsequent two patches add support for requesting DMAs to MFD core
- Next three patches add support for capture to stm32-pwm driver
- This has been tested on stm32429i-eval board.

---
Changes in v2:
- Abstract DMA handling from child driver: move it to MFD core
- Rework pwm capture routines to adopt this change
- Comment on optional dma support, beautify DMAs probe

Fabrice Gasnier (8):
  pwm: stm32: fix, remove unused struct device
  pwm: stm32: protect common prescaler for all channels
  dt-bindings: mfd: stm32-timers: add support for dmas
  mfd: stm32-timers: add support for dmas
  pwm: stm32: add capture support
  pwm: stm32: improve capture by tuning counter prescaler
  pwm: stm32: use input prescaler to improve period capture
  ARM: dts: stm32: Enable pwm3 input capture on stm32f429i-eval

 .../devicetree/bindings/mfd/stm32-timers.txt       |  20 ++
 arch/arm/boot/dts/stm32429i-eval.dts               |   3 +
 drivers/mfd/stm32-timers.c                         | 215 +++++++++++++++-
 drivers/pwm/pwm-stm32.c                            | 276 ++++++++++++++++++++-
 include/linux/mfd/stm32-timers.h                   |  39 +++
 5 files changed, 547 insertions(+), 6 deletions(-)

-- 
1.9.1
