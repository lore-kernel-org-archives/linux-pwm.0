From: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH 2/2] PCI: armada8k: don't toggle reset twice
Date: Thu, 10 Jan 2019 14:26:22 +0200
Message-ID: <94cd23a60c647020dd87a923684b59255b89f02c.1547123182.git.baruch@tkos.co.il>
References: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pwm@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, Sven Auhagen <sven.auhagen@voleatech.de>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Commit 3d71746c42 ("PCI: armada8k: Add support for gpio controlled reset
signal") added reset signal support. Reset is unconditionally asserted
and deasserted.

Unfortunately, that commit breaks boot on Macchiatobin when a Mellanox
NIC is in the PCIe slot.

It turns out that you can toggle the reset signal only once. Another
reset signal toggle makes access to PCI configuration registers stall
indefinitely. U-Boot toggles the Macchiatobin PCIe reset line already at
boot.

Detect whether the bootloader changed the reset signal state using the
get_direction operation. If direction is output don't touch the reset
signal again. Otherwise, set direction to output and keep the reset
asserted.

Reported-by: Sven Auhagen <sven.auhagen@voleatech.de>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---

This patch depends on the mvebu get_direction implementation in the
patch #1 of this series. Since get_direction implementation is not a
pure fix it might be considered unfit for v5.0. In that case I'm OK with
reverting 3d71746c42 in v5.0 to fix the Macchiatobin regression, and
postpone this series to v5.1.
---
 drivers/pci/controller/dwc/pcie-armada8k.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index b171b6bc15c8..132a86a1e1e7 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -257,12 +257,23 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 		goto fail_clkreg;
 	}
 
-	/* Get reset gpio signal and hold asserted (logically high) */
+	/* Get reset gpio signal, don't change its setting */
 	pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset",
-						   GPIOD_OUT_HIGH);
+						   GPIOD_ASIS);
 	if (IS_ERR(pcie->reset_gpio)) {
 		ret = PTR_ERR(pcie->reset_gpio);
 		goto fail_clkreg;
+	} else if (pcie->reset_gpio &&
+			gpiod_get_direction(pcie->reset_gpio) == 0) {
+		/* Reset signal is output. The bootloader has deasserted reset
+		 * signal already. Don't do it again.
+		 */
+		dev_info(dev, "%s: leave reset signal unchanged\n", __func__);
+		devm_gpiod_put(dev, pcie->reset_gpio);
+		pcie->reset_gpio = NULL;
+	} else if (pcie->reset_gpio) {
+		/* Assert reset */
+		gpiod_direction_output(pcie->reset_gpio, 1);
 	}
 
 	platform_set_drvdata(pdev, pcie);
-- 
2.20.1
