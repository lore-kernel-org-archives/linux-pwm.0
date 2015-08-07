From: Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH] pwm: core: cleanup pointer tests
Date: Fri, 07 Aug 2015 20:18:52 +0200
Message-ID: <55C4F68C.9070200@schinagl.nl>
References: <1438958976-1821-1-git-send-email-oliver+list@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 7of9.schinagl.nl ([88.159.158.68]:57174 "EHLO 7of9.schinagl.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945916AbbHGSSy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Fri, 7 Aug 2015 14:18:54 -0400
In-Reply-To: <1438958976-1821-1-git-send-email-oliver+list@schinagl.nl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Olliver Schinagl <oliver+list@schinagl.nl>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hey list,

After working on a new pwm-driver I noticed that not everybody actually 
has the set_polarity op and thus its an optional property. For a moment 
I figured I could add a 'software' polarity function by inverting the 
calculation of the on/off time, but I don't even have the hardware to 
test it so ...

Sorry for the noise, this patch can be ignored.

Olliver

On 07-08-15 16:49, Olliver Schinagl wrote:
> From: Olliver Schinagl <oliver@schinagl.nl>
>
> pwm_set_polarity() checks if there's ops and polarity function pointers.
> Most of these pointers are actually checked when a chip is added via
> pwm_add, except for set_polarity.
>
> This patch adds set_polarity to the list of functions to test on
> pwmchip_add_with_polarity(); and removes these checks from
> pwm_set_polarity.
>
> The pwm should be valid, as it was checked during
> pwmchip_add_with_polarity().
>
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> ---
>   drivers/pwm/core.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 3a7769f..66fd5fd 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -239,7 +239,8 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
>   	int ret;
>   
>   	if (!chip || !chip->dev || !chip->ops || !chip->ops->config ||
> -	    !chip->ops->enable || !chip->ops->disable || !chip->npwm)
> +	    !chip->ops->set_polarity || !chip->ops->enable ||
> +	    !chip->ops->disable || !chip->npwm)
>   		return -EINVAL;
>   
>   	mutex_lock(&pwm_lock);
> @@ -449,12 +450,9 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
>   {
>   	int err;
>   
> -	if (!pwm || !pwm->chip->ops)
> +	if (!pwm)
>   		return -EINVAL;
>   
> -	if (!pwm->chip->ops->set_polarity)
> -		return -ENOSYS;
> -
>   	if (test_bit(PWMF_ENABLED, &pwm->flags))
>   		return -EBUSY;
>   
