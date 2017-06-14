From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v2 0/3] Fix STM32 timers dt-bindings
Date: Wed, 14 Jun 2017 17:13:13 +0200
Message-ID: <1497453196-31470-1-git-send-email-fabrice.gasnier@st.com>
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
To: lee.jones@linaro.org, benjamin.gaignard@linaro.org, jic23@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: linux-pwm@vger.kernel.org

STM32 timers clock names has been updated during driver/DT binding review:
https://lkml.org/lkml/2016/12/13/718

STM32 timers driver has been fixed with these remarks. It looks like it's
been missed on DT binding part.
Update DT binding doc to reflect this as well.
---
Changes in v2:
- Also fix stm32 pwm dt-bindings
- Add Fixes tags

Fabrice Gasnier (3):
  dt-bindings: mfd: update STM32 timers clock names
  dt-bindings: iio: update STM32 timers clock names
  dt-bindings: pwm: update STM32 timers clock names

 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt | 2 +-
 Documentation/devicetree/bindings/mfd/stm32-timers.txt              | 2 +-
 Documentation/devicetree/bindings/pwm/pwm-stm32.txt                 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.9.1
