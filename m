From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH 2/2] PCI: armada8k: don't toggle reset twice
Date: Mon, 14 Jan 2019 09:19:09 +0200
Message-ID: <20190114071909.5cz4pg4bsdo7htob@sapphire.tkos.co.il>
References: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
 <94cd23a60c647020dd87a923684b59255b89f02c.1547123182.git.baruch@tkos.co.il>
 <20190110125548.GA29612@lunn.ch> <8736q0irwy.fsf@tarshish>
 <20190110131912.GB29612@lunn.ch> <87zhs8h5ej.fsf@tarshish>
 <87pnt0vil3.fsf@tarshish> <20190113154028.GB4635@lunn.ch>
 <CACRpkdY6UPcWds3swtRM_OMu3hCJcdicbo29b5JEcRBNC4L+vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdY6UPcWds3swtRM_OMu3hCJcdicbo29b5JEcRBNC4L+vg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sven Auhagen <sven.auhagen@voleatech.de>, Jason Cooper <jason@lakedaemon.net>, linux-pwm@vger.kernel.org, linux-pci <linux-pci@vger.kernel.org>, Gregory Clement <gregory.clement@bootlin.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Bjorn Helgaas <bhelgaas@google.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Hi Linus,

On Mon, Jan 14, 2019 at 12:35:01AM +0100, Linus Walleij wrote:
> On Sun, Jan 13, 2019 at 4:40 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > > Another look at this comment made me realize that we need comphy
> > > initialization support in the kernel for PCIe reset to work correctly.
> > >
> > > The workaround that this patch proposes will not solve the problem for
> > > v5.0, since the GPIO get_direction patch will only appear in v5.1.
> >
> > You could ask for it to be applied to v5.0 since a real fix depends on
> > it.
> 
> If it makes a piece of hardware work that was working before and
> now is not working as a result of other kernel changes I would
> definately apply it because that is a clear cut regression.
> 
> I am under the impression that this is the case?

The gpio-mvebu get_direction support enables a workaround for a regression 
introduced in commit 3d71746c420c1 on the Macchiatobin platform. An 
alternative solution is to revert the offending commit. The revert will not 
break any known platform that has been previously supported in mainline 
kernel. I tend to think that revert is a better course of action.

It is up to the PCI maintainers to decide.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
