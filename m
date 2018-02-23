From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [RESEND PATCH 0/3] Add pwm-cells on STM32 LPTimer
Date: Fri, 23 Feb 2018 14:36:02 +0100
Message-ID: <1519392965-28235-1-git-send-email-fabrice.gasnier@st.com>
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
To: thierry.reding@gmail.com, alexandre.torgue@st.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, benjamin.gaignard@linaro.org, linux-pwm@vger.kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Add missing generic #pwm-cells on STM32 LPTimer to allow initialization
of channel, period and polarity.

Fabrice Gasnier (1):
  ARM: dts: stm32: update pwm-cells for LPTimer on stm32h743

Gerald Baeza (2):
  dt-bindings: pwm-stm32-lp: add #pwm-cells
  pwm: stm32: LPTimer: use 3 cells xlate

 Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt | 3 +++
 arch/arm/boot/dts/stm32h743.dtsi                       | 5 +++++
 drivers/pwm/pwm-stm32-lp.c                             | 2 ++
 3 files changed, 10 insertions(+)

-- 
1.9.1
