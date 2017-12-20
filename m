From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 2/5] dt-bindings: pwm: rcar: Document r8a774[35] PWM
 bindings
Date: Wed, 20 Dec 2017 11:12:31 +0100
Message-ID: <20171220101223.kwnm7kpf7hssuxbc@verge.net.au>
References: <1513690500-12165-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1513690500-12165-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <20171220083137.63jj4rrkztguvvbm@verge.net.au>
 <TY1PR06MB08955E0D55B2712C6105A2F0C00C0@TY1PR06MB0895.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <TY1PR06MB08955E0D55B2712C6105A2F0C00C0@TY1PR06MB0895.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Wed, Dec 20, 2017 at 09:54:14AM +0000, Fabrizio Castro wrote:
> Hello Simon,
> 
> > Subject: Re: [PATCH v3 2/5] dt-bindings: pwm: rcar: Document r8a774[35] PWM bindings
> >
> > On Tue, Dec 19, 2017 at 01:34:57PM +0000, Fabrizio Castro wrote:
> > > This patch adds compatible strings specific to r8a774[35], no driver
> > > change is needed as the fallback compatible string will activate the
> > > right code. Also, this patch replaces the example with a DT snippet used
> > > for adding PWM0 support to an r8a7743 based platform.
> >
> > What is the motivation for updating the example?
> 
> I am sorry I forgot to copy the explanation across from the first version of the patch:
> https://patchwork.kernel.org/patch/10111831/
> 
> "the reason for replacing the example with one of a different SoC is that
> the new example refers to recent code from a real use case. I hope that's ok."
> 
> Basically the r8a7743 will be the first platform with full upstream support, and I believe it is better to have up-to-date examples proven to work in the documentation.

Thanks, that sounds reasonable.

> 
> > Could it be stated here?
> 
> Shall I send a new version for this?

That would be best in my opinion.
