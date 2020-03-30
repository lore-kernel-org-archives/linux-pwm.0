From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 1/4] pwm: sun4i: Remove redundant needs_delay
Date: Mon, 30 Mar 2020 16:16:57 +0200
Message-ID: <20200330141657.GH2431644@ulmo>
References: <20200317155906.31288-1-dev@pascalroeleven.nl>
 <20200317155906.31288-2-dev@pascalroeleven.nl>
Reply-To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v2Uk6McLiE8OV1El"
Return-path: <linux-sunxi+bncBDTKFPPJUEHRBXP6Q72AKGQEVR6BHJQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20200317155906.31288-2-dev-/1Tg0gxlrOS4ObxHbWkkimZHpeb/A1Y/@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Pascal Roeleven <dev-/1Tg0gxlrOS4ObxHbWkkimZHpeb/A1Y/@public.gmane.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--v2Uk6McLiE8OV1El
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Tue, Mar 17, 2020 at 04:59:03PM +0100, Pascal Roeleven wrote:
> 'needs_delay' does now always evaluate to true, so remove all
> occurrences.
> 
> Signed-off-by: Pascal Roeleven <dev-/1Tg0gxlrOS4ObxHbWkkimZHpeb/A1Y/@public.gmane.org>
> ---
>  drivers/pwm/pwm-sun4i.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)

I've applied this one since it's obviously correct. I'll hold off on the
others until it can be more broadly tested. Hopefully Maxime or Chen-Yu
can help review the remainder of this series as well.

Thierry
--v2Uk6McLiE8OV1El--
