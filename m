From: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dts: imx: default to #pwm-cells = <3> in the SoC
 dtsi files
Date: Mon, 13 Jul 2020 16:48:40 +0800
Message-ID: <20200713084839.GG15718@dragon>
References: <20200710051937.20647-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200710051937.20647-1-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Paul Barker <pbarker-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Ranostay <matt.ranostay-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Fri, Jul 10, 2020 at 07:19:37AM +0200, Uwe Kleine-König wrote:
> The imx-pwm driver supports 3 cells and this is the more flexible setting.
> So use it by default and overwrite it back to two for the files that
> reference the PWMs with just 2 cells to minimize changes.
> 
> This allows to drop explicit setting to 3 cells for the boards that already
> depend on this. The boards that are now using 2 cells explicitly can be
> converted to 3 individually.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Applied, thanks.
