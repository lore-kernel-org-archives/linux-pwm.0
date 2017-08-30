From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 7/8] arm64: dts: r8a7795-salvator-x: Enable PWM2
Date: Wed, 30 Aug 2017 10:08:24 +0200
Message-ID: <20170830080823.GP10398@verge.net.au>
References: <1493303863-23719-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1493303863-23719-8-git-send-email-ulrich.hecht+renesas@gmail.com>
 <5664970.rvzlHsyOZi@avalon>
 <20170830080629.GO10398@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170830080629.GO10398@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, geert@glider.be, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, Takeshi Kihara <takeshi.kihara.df@renesas.com>
List-Id: linux-pwm@vger.kernel.org

On Wed, Aug 30, 2017 at 10:06:30AM +0200, Simon Horman wrote:
> On Thu, Apr 27, 2017 at 05:40:51PM +0300, Laurent Pinchart wrote:
> > Hi Ulrich,
> > 
> > Thank you for the patch.
> > 
> > On Thursday 27 Apr 2017 16:37:42 Ulrich Hecht wrote:
> > > From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > > 
> > > This patch enables PWM2 for Salvator-X board on R8A7795 SoC.
> > > 
> > > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> > > b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts index 8558b27..534b17e
> > > 100644
> > > --- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> > > +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> > > @@ -381,6 +381,11 @@
> > >  		function = "pwm1";
> > >  	};
> > > 
> > > +	pwm2_pins: pwm2 {
> > > +		groups = "pwm2_a";
> > > +		function = "pwm2";
> > > +	};
> > > +
> > >  	sdhi0_pins: sd0 {
> > >  		groups = "sdhi0_data4", "sdhi0_ctrl";
> > >  		function = "sdhi0";
> > > @@ -463,6 +468,13 @@
> > >  	status = "okay";
> > >  };
> > > 
> > > +&pwm2 {
> > > +	/* PMIC DC/DC switching frequency synchronization */
> > 
> > Please pardon the stupid question, but if the PWM channel is used by the PMIC, 
> > is there a point in enabling it without a PMIC DT node using it ?
> 
> Hi Ulrich,
> 
> I'm wondering if you have any plans to follow-up on this patch.

And likewise
"[v2,5/8] arm64: dts: r8a7796-salvator-x: Add PWM device support"
