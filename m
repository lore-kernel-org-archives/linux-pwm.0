From: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 0/4] Convert STM32 Timer mdf bindings to yaml
Date: Thu, 31 Oct 2019 13:30:36 +0100
Message-ID: <20191031123040.26316-1-benjamin.gaignard@st.com>
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
To: robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com, fabrice.gasnier@st.com, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, benjamin.gaignard@st.com
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

This series converts STM32 Timer mfd bindings to json-schema.
The original binding split between all the subnode remains the same
that why subnode bindings are converted first and then included in
the mfd binding.

Benjamin Gaignard (4):
  dt-bindings: counter: Convert stm32 counter bindings to json-schema
  dt-bindings: iio: timer: Convert stm32 IIO trigger bindings to
    json-schema
  dt-bindings: pwm: Convert stm32 pwm bindings to json-schema
  dt-bindings: mfd: Convert stm32 timers bindings to json-schema

 .../bindings/counter/st,stm32-timer-cnt.yaml       | 38 +++++++++
 .../bindings/counter/stm32-timer-cnt.txt           | 31 --------
 .../bindings/iio/timer/st,stm32-timer-trigger.yaml | 44 +++++++++++
 .../bindings/iio/timer/stm32-timer-trigger.txt     | 25 ------
 .../devicetree/bindings/mfd/st,stm32-timers.yaml   | 91 ++++++++++++++++++++++
 .../devicetree/bindings/mfd/stm32-timers.txt       | 73 -----------------
 .../devicetree/bindings/pwm/pwm-stm32.txt          | 38 ---------
 .../devicetree/bindings/pwm/st,stm32-pwm.yaml      | 51 ++++++++++++
 8 files changed, 224 insertions(+), 167 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/counter/st,stm32-timer-cnt.yaml
 delete mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
 create mode 100644 Documentation/devicetree/bindings/iio/timer/st,stm32-timer-trigger.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/stm32-timers.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/st,stm32-pwm.yaml

-- 
2.15.0
