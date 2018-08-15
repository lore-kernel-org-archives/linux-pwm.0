From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v1 3/7] mfd: add atmel-lcdc driver
Date: Wed, 15 Aug 2018 22:40:41 +0200
Message-ID: <20180815204041.GA29041@ravnborg.org>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812184629.3808-3-sam@ravnborg.org>
 <20180815052435.GA6412@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180815052435.GA6412@dell>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pwm@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, dri-devel@lists.freedesktop.org, Boris Brezillon <boris.brezillon@bootlin.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Lee.

> > +
> > +static const struct mfd_cell lcdc_cells[] = {
> > +	{
> > +		.name = "atmel-lcdc-pwm",
> > +		.of_compatible = "atmel,lcdc-pwm",
> > +	},
> > +	{
> > +		.name = "atmel-lcdc-dc",
> > +		.of_compatible = "atmel,lcdc-display-controller",
> > +	},
> > +};
> 
> Will you be adding any more devices, or is this the entirety of the
> device?  If the latter, I suggest that this doesn't warrant being an
> MFD.
Thats it. And others agree with you that this is not a good approach.
So in v2 there will be no MFD.

Thanks for confirming that the non-mfd way is the better approach.

	Sam
