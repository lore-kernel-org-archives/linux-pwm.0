From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH v9 0/2] PWM: pwm-atmel: add PWM controller driver
Date: Fri, 13 Dec 2013 14:41:48 +0800
Message-ID: <1386916910-24832-1-git-send-email-voice.shen@atmel.com>
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
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, nicolas.ferre@atmel.com, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, Bo Shen <voice.shen@atmel.com>, galak@codeaurora.org, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

This patch series add Atmel PWM controller driver support.

Changes in v9:
  - Address the comments from Thierry Reding

Changes in v8:
  - replace pr_err by dev_err

Changes in v7:
  - fix issue for none device tree issues.

Changes in v6:
  - using relaxed version for writel and readl
  - add none device tree support
  - change some define from lower case to upper case
  - split device tree binding document as a separate patch

Changes in v5:
  - call clk_disable directly, if so, it won't cause more than one channel
    enabled, the clock can not be disabled.

Changes in v4:
  - check the return value of clk_prepare()
  - change channel register size as constant

Changes in v3:
  - change compatible string from "atmel,sama5-pwm" to "atmel,sama5d3-pwm"
  - Add PWM led example in binding documentation
  - Using micro replace hard code

Changes in v2:
  - Address the comments from Thierry Reding


Bo Shen (2):
  PWM: atmel-pwm: add PWM controller driver
  PWM: atmel-pwm: add device tree binding document

 .../devicetree/bindings/pwm/atmel-pwm.txt          |   41 ++
 drivers/pwm/Kconfig                                |    9 +
 drivers/pwm/Makefile                               |    1 +
 drivers/pwm/pwm-atmel.c                            |  398 ++++++++++++++++++++
 4 files changed, 449 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel-pwm.txt
 create mode 100644 drivers/pwm/pwm-atmel.c

-- 
1.7.9.5
