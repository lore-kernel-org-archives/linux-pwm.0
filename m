From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH 2/2] PCI: armada8k: don't toggle reset twice
Date: Thu, 10 Jan 2019 15:05:49 +0200
Message-ID: <8736q0irwy.fsf@tarshish>
References: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
 <94cd23a60c647020dd87a923684b59255b89f02c.1547123182.git.baruch@tkos.co.il>
 <20190110125548.GA29612@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20190110125548.GA29612@lunn.ch>
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
> On Thu, Jan 10, 2019 at 02:26:22PM +0200, Baruch Siach wrote:
>> Commit 3d71746c42 ("PCI: armada8k: Add support for gpio controlled reset
>> signal") added reset signal support. Reset is unconditionally asserted
>> and deasserted.
>>
>> Unfortunately, that commit breaks boot on Macchiatobin when a Mellanox
>> NIC is in the PCIe slot.
>>
>> It turns out that you can toggle the reset signal only once. Another
>> reset signal toggle makes access to PCI configuration registers stall
>> indefinitely. U-Boot toggles the Macchiatobin PCIe reset line already at
>> boot.
>
> Hi Baruch
>
> Is this double reset issue limited to just Mellanox NICs, or any
> device in the PCIe slot?
>
> This sounds more like a workaround than a fix. It would be good to
> investigate further and determine which end of the PCIe link has the
> problem.

Sven Auhagen reported the same issue with Intel NIC attached to
mini-PCIe slots on a custom Armada 8K design.

How would you suggest to investigate this issue?

baruch

--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
