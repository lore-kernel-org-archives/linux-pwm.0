From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 1/4] ARM: pwm: sun4i: unification of
 register operations for support sun6i.
Date: Wed, 8 Feb 2017 08:52:19 +0100
Message-ID: <20170208075219.oo234d5zartzmzsg@lukather>
References: <1486489846-662-1-git-send-email-lis8215@gmail.com>
 <1486489846-662-2-git-send-email-lis8215@gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z7qpwgh2ly4sj6vp"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBVNR5PCAKGQEGHEIWRI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1486489846-662-2-git-send-email-lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--z7qpwgh2ly4sj6vp
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Tue, Feb 07, 2017 at 08:50:43PM +0300, lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> This patch not introduce new features, just prepare code for
> adding sun6i PWM driver in next commits.
> 
> A31 SoC have a different map of PWM registers than others ASoCs,
> but register bits purposes are very similar.
> 
> This patch introduce set of register access routines, which
> are common for existing in driver ASoCs:
>  - ctl_rdy   - checks the ready bit of specified PWM channel,
>  - ctl_read  - reads value from control register of specified PWM channel,
>  - ctl_write - writes significant bits to control register of specified PWM channel,
>  - prd_read  - reads value from period register of specified PWM channel,
>  - prd_write - writes value to period register of specified PWM channel.
> Driver code redesigned to use the new routines.

Why don't you use regmap for that?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--z7qpwgh2ly4sj6vp--
