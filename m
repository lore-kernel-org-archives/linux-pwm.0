From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 4/9] pwm: sunxi: Customizable control and
 period register position.
Date: Tue, 28 Feb 2017 16:48:50 +0100
Message-ID: <20170228154850.75uqjzcei7pkb4rd@lukather>
References: <1487914876-8594-1-git-send-email-lis8215@gmail.com>
 <1487914876-8594-5-git-send-email-lis8215@gmail.com>
 <20170227093026.zsau7vbugmizivz2@lukather>
 <CAKNVLfa6NgRBSVZgOb5yp31Eq8nZYRSKQzgUzoXL5_QFfYVjeQ@mail.gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ndzrufzmvr546cjp"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBB3NX23CQKGQEXZNFJ4I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <CAKNVLfa6NgRBSVZgOb5yp31Eq8nZYRSKQzgUzoXL5_QFfYVjeQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--ndzrufzmvr546cjp
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, Feb 27, 2017 at 03:35:04PM +0300, Siarhei Volkau wrote:
> Hi,
> 
> 2017-02-27 12:30 GMT+03:00 Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>:
> > On Fri, Feb 24, 2017 at 08:41:11AM +0300, lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> >> From: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>
> >> sun6i has same registers as sun4i compatible chips, but its position
> >> in register map are different.
> >>
> >> This patch make register's position selectable for support sun6i in
> >> next patches.
> >>
> >> Signed-off-by: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> ---
> >>  drivers/pwm/pwm-sun4i.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++---
> >>  1 file changed, 54 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> >> index 418a625..9ddc812 100644
> >> --- a/drivers/pwm/pwm-sun4i.c
> >> +++ b/drivers/pwm/pwm-sun4i.c
> >> @@ -79,11 +79,17 @@ static const u32 sun4i_prescaler_table[] = {
> >>       0, /* Actually 1 but tested separately */
> >>  };
> >>
> >> +struct sunxi_pwmch_data {
> >> +     unsigned int ctl_reg;
> >> +     unsigned int prd_reg;
> >> +};
> >> +
> >
> > Why don't you use regmap_fields for that too?
> >
> > Maxime
> >
> > --
> > Maxime Ripard, Free Electrons
> > Embedded Linux and Kernel engineering
> > http://free-electrons.com
> 
> Period register contains 2 fields (duty cycle and active period),
> A20 user manual says:
> (C) Note: the active cycles should be no larger than the period cycles.
> 
> I just try to avoid situation when active cycles can have bigger value
> than duty cycle. Regmap fields not allows update 2
> or more fields simultaneously, or maybe i'm not found this.
> 
> Same situation with enable/disable bitmask in control register.
> Updating these bits (clock gating and enable) in different moments
> in time can produce some artefacts on pwm output signal.

That really should be dealt with in the driver itself though, and not
in your accessor. It's up to the driver to use the accessor in a way
that makes sense for that particular device.

All these constraints should be documented, but you don't need to
change the way you access those registers to do that (unless you
really really really have no other way to do so).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--ndzrufzmvr546cjp--
