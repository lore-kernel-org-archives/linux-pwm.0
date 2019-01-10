From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH 2/2] PCI: armada8k: don't toggle reset twice
Date: Thu, 10 Jan 2019 17:57:24 +0200
Message-ID: <87zhs8h5ej.fsf@tarshish>
References: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
 <94cd23a60c647020dd87a923684b59255b89f02c.1547123182.git.baruch@tkos.co.il>
 <20190110125548.GA29612@lunn.ch> <8736q0irwy.fsf@tarshish>
 <20190110131912.GB29612@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20190110131912.GB29612@lunn.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-pwm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sven Auhagen <sven.auhagen@voleatech.de>, Jason Cooper <jason@lakedaemon.net>, linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Bjorn Helgaas <bhelgaas@google.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Hi Andrew,

On Thu, Jan 10 2019, Andrew Lunn wrote:
>> Sven Auhagen reported the same issue with Intel NIC attached to
>> mini-PCIe slots on a custom Armada 8K design.
>
> O.K. so that suggests the issue is on the Armada side.
>  
>> How would you suggest to investigate this issue?
>
> I presume reboot works O.K? So it is possible to toggle the reset
> multiple times, but reboot must do something additional which makes it
> work? Do you have sources for the bootloader?

The bootloader is current U-Boot master as BL33 of Marvell provided ATF
version 18.12, current latest.

> Are there status bits in the comphy about the state of the link? Maybe
> comphy needs to be kicked to reestablish the link?

Maybe. The U-Boot comphy PCIe initialization routine
comphy_pcie_power_up() is long and complex.

The ATF code also carries PCIe comphy initialization with this text:

https://github.com/MarvellEmbeddedProcessors/atf-marvell/blob/atf-v1.5-armada-18.12/drivers/marvell/comphy/phy-comphy-cp110.c#L1170

        /* In Armada 8K DB boards, PCIe initialization can be executed
         * only once (PCIe reset performed during chip power on and
         * it cannot be executed via GPIO later).
         * This means that power on can be executed only once, so let's
         * mark if the caller is bootloader or Linux.
         * If bootloader -> run power on.
         * If Linux -> exit.
         *
         * TODO: In MacciatoBIN, PCIe reset is connected via GPIO,
         * so after GPIO reset is added to Linux Kernel, it can be
         * powered-on by Linux.
         */
        if (!called_from_uboot)
                return ret;

It looks like vendor code is using a similar trick.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
