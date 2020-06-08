From: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 03/11] irqchip: add sl28cpld interrupt controller
 support
Date: Mon, 8 Jun 2020 23:12:47 +0800
Message-ID: <20200608151247.GC31689@xsang-OptiPlex-9020>
References: <20200604211039.12689-4-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200604211039.12689-4-michael@walle.cc>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Michael Walle <michael@walle.cc>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, kbuild-all@lists.01.org
List-Id: linux-pwm@vger.kernel.org

Hi Michael,

I love your patch! Perhaps something to improve:

[auto build test WARNING on next-20200604]
[cannot apply to gpio/for-next hwmon/hwmon-next ljones-mfd/for-mfd-next shawnguo/for-next v5.7 v5.7-rc7 v5.7-rc6 v5.7]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Michael-Walle/Add-support-for-Kontron-sl28cpld/20200605-051333
base:    d4899e5542c15062cc55cac0ca99025bb64edc61
:::::: branch date: 26 hours ago
:::::: commit date: 26 hours ago
compiler: gcc-9 (Debian 9.3.0-13) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/irqchip/irq-sl28cpld.c:56:10: warning: Checking if unsigned variable 'irq' is less than zero. [unsignedLessThanZero]
    if (irq < 0)
            ^

# https://github.com/0day-ci/linux/commit/b13743c1f1a52746beaa071e5d008c84d59fbd7f
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout b13743c1f1a52746beaa071e5d008c84d59fbd7f
vim +/irq +56 drivers/irqchip/irq-sl28cpld.c

b13743c1f1a527 Michael Walle 2020-06-04  35  
b13743c1f1a527 Michael Walle 2020-06-04  36  static int sl28cpld_intc_probe(struct platform_device *pdev)
b13743c1f1a527 Michael Walle 2020-06-04  37  {
b13743c1f1a527 Michael Walle 2020-06-04  38  	struct device *dev = &pdev->dev;
b13743c1f1a527 Michael Walle 2020-06-04  39  	struct sl28cpld_intc *irqchip;
b13743c1f1a527 Michael Walle 2020-06-04  40  	unsigned int irq;
b13743c1f1a527 Michael Walle 2020-06-04  41  	u32 base;
b13743c1f1a527 Michael Walle 2020-06-04  42  	int ret;
b13743c1f1a527 Michael Walle 2020-06-04  43  
b13743c1f1a527 Michael Walle 2020-06-04  44  	if (!dev->parent)
b13743c1f1a527 Michael Walle 2020-06-04  45  		return -ENODEV;
b13743c1f1a527 Michael Walle 2020-06-04  46  
b13743c1f1a527 Michael Walle 2020-06-04  47  	irqchip = devm_kzalloc(dev, sizeof(*irqchip), GFP_KERNEL);
b13743c1f1a527 Michael Walle 2020-06-04  48  	if (!irqchip)
b13743c1f1a527 Michael Walle 2020-06-04  49  		return -ENOMEM;
b13743c1f1a527 Michael Walle 2020-06-04  50  
b13743c1f1a527 Michael Walle 2020-06-04  51  	irqchip->regmap = dev_get_regmap(dev->parent, NULL);
b13743c1f1a527 Michael Walle 2020-06-04  52  	if (!irqchip->regmap)
b13743c1f1a527 Michael Walle 2020-06-04  53  		return -ENODEV;
b13743c1f1a527 Michael Walle 2020-06-04  54  
b13743c1f1a527 Michael Walle 2020-06-04  55  	irq = platform_get_irq(pdev, 0);
b13743c1f1a527 Michael Walle 2020-06-04 @56  	if (irq < 0)
b13743c1f1a527 Michael Walle 2020-06-04  57  		return irq;
b13743c1f1a527 Michael Walle 2020-06-04  58  
b13743c1f1a527 Michael Walle 2020-06-04  59  	ret = device_property_read_u32(&pdev->dev, "reg", &base);
b13743c1f1a527 Michael Walle 2020-06-04  60  	if (ret)
b13743c1f1a527 Michael Walle 2020-06-04  61  		return -EINVAL;
b13743c1f1a527 Michael Walle 2020-06-04  62  
b13743c1f1a527 Michael Walle 2020-06-04  63  	irqchip->chip.name = "sl28cpld-intc";
b13743c1f1a527 Michael Walle 2020-06-04  64  	irqchip->chip.irqs = sl28cpld_irqs;
b13743c1f1a527 Michael Walle 2020-06-04  65  	irqchip->chip.num_irqs = ARRAY_SIZE(sl28cpld_irqs);
b13743c1f1a527 Michael Walle 2020-06-04  66  	irqchip->chip.num_regs = 1;
b13743c1f1a527 Michael Walle 2020-06-04  67  	irqchip->chip.status_base = base + INTC_IP;
b13743c1f1a527 Michael Walle 2020-06-04  68  	irqchip->chip.mask_base = base + INTC_IE;
b13743c1f1a527 Michael Walle 2020-06-04  69  	irqchip->chip.mask_invert = true,
b13743c1f1a527 Michael Walle 2020-06-04  70  	irqchip->chip.ack_base = base + INTC_IP;
b13743c1f1a527 Michael Walle 2020-06-04  71  
b13743c1f1a527 Michael Walle 2020-06-04  72  	return devm_regmap_add_irq_chip_np(&pdev->dev, dev->of_node,
b13743c1f1a527 Michael Walle 2020-06-04  73  					   irqchip->regmap, irq,
b13743c1f1a527 Michael Walle 2020-06-04  74  					   IRQF_SHARED | IRQF_ONESHOT, 0,
b13743c1f1a527 Michael Walle 2020-06-04  75  					   &irqchip->chip, &irqchip->irq_data);
b13743c1f1a527 Michael Walle 2020-06-04  76  }
b13743c1f1a527 Michael Walle 2020-06-04  77  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
