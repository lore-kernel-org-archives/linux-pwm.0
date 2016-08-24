From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] pwm: sun4i: fix a possible NULL dereference
Date: Wed, 24 Aug 2016 14:39:11 +0200
Message-ID: <20160824123911.GC3714@ulmo.ba.sec>
References: <1472039038-4047-1-git-send-email-clabbe.montjoie@gmail.com>
Reply-To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Return-path: <linux-sunxi+bncBDTKFPPJUEHRB4NK626QKGQETQXCRGY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1472039038-4047-1-git-send-email-clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: LABBE Corentin <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Wed, Aug 24, 2016 at 01:43:58PM +0200, LABBE Corentin wrote:
> of_match_device could return NULL, and so cause a NULL pointer
> dereference later.
> 
> For fixing this problem, we use of_device_get_match_data(), this will
> simplify the code a little by using a standard function for
> getting the match data.
> 
> Testing the return value of of_device_get_match_data is also necessary
> for avoiding a second NULL deref on pwm->data.
> 
> Reported-by: coverity (CID 1324139)
> Signed-off-by: LABBE Corentin <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> Changes since v2:
>  - Add a test on pwm->data for avoiding a second NULL deref.
> Changes since v1:
>  - Use of_device_get_match_data()
> 
>  drivers/pwm/pwm-sun4i.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 03a99a5..fb76c55 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -309,9 +309,6 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	u32 val;
>  	int i, ret;
> -	const struct of_device_id *match;
> -
> -	match = of_match_device(sun4i_pwm_dt_ids, &pdev->dev);
>  
>  	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
>  	if (!pwm)
> @@ -326,7 +323,9 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  	if (IS_ERR(pwm->clk))
>  		return PTR_ERR(pwm->clk);
>  
> -	pwm->data = match->data;
> +	pwm->data = of_device_get_match_data(&pdev->dev);
> +	if (!pwm->data)
> +		return -EINVAL;

I don't see how this would ever be NULL. You'd have to add an entry to
the table that has a NULL data field, which is very unlikely to happen.
If you really want to check for this, which I think isn't necessary,
please wrap this in a WARN_ON() or something to make more noise when
this completely unexpected case happens.

Thierry
--32u276st3Jlj2kUU--
