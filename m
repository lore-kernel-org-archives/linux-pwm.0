From: Jonathan Richardson <jonathar@broadcom.com>
Subject: Re: [PATCH v9 2/2] pwm: core: Set enable state properly on failed
 call to enable
Date: Fri, 16 Oct 2015 11:27:42 -0700
Message-ID: <5621419E.1050806@broadcom.com>
References: <1434403262-24198-1-git-send-email-jonathar@broadcom.com> <1434403262-24198-3-git-send-email-jonathar@broadcom.com> <557F5E33.2050706@broadcom.com> <20150817143108.GD6891@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150817143108.GD6891@ulmo.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Tim Kryger <tim.kryger@gmail.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 15-08-17 07:31 AM, Thierry Reding wrote:
> On Mon, Jun 15, 2015 at 04:22:27PM -0700, Jonathan Richardson wrote:
>> On 15-06-15 02:21 PM, Jonathan Richardson wrote:
>>> The pwm_enable function didn't clear the enabled bit if a call to a
>>> clients enable function returned an error. The result was that the state
>>> of the pwm core was wrong. Clearing the bit when enable returns an error
>>> ensures the state is properly set.
>>>
>>> Tested-by: Jonathan Richardson <jonathar@broadcom.com>
>>> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>> Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
>>> ---
>>>  drivers/pwm/core.c  |   19 ++++++++++++++++---
>>>  include/linux/pwm.h |    2 ++
>>>  2 files changed, 18 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
>>> index 76b0386..c255267 100644
>>> --- a/drivers/pwm/core.c
>>> +++ b/drivers/pwm/core.c
>>> @@ -263,6 +263,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
>>>  		pwm->pwm = chip->base + i;
>>>  		pwm->hwpwm = i;
>>>  		pwm->polarity = polarity;
>>> +		mutex_init(&pwm->lock);
>>>  
>>>  		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
>>>  	}
>>> @@ -474,10 +475,22 @@ EXPORT_SYMBOL_GPL(pwm_set_polarity);
>>>   */
>>>  int pwm_enable(struct pwm_device *pwm)
>>>  {
>>> -	if (pwm && !test_and_set_bit(PWMF_ENABLED, &pwm->flags))
>>> -		return pwm->chip->ops->enable(pwm->chip, pwm);
>>> +	int err = 0;
>>>  
>>> -	return pwm ? 0 : -EINVAL;
>>> +	if (!pwm)
>>> +		return -EINVAL;
>>> +
>>> +	mutex_lock(&pwm->lock);
>>> +
>>> +	if (!test_and_set_bit(PWMF_ENABLED, &pwm->flags)) {
>>> +		err = pwm->chip->ops->enable(pwm->chip, pwm);
>>> +		if (err)
>>> +			clear_bit(PWMF_ENABLED, &pwm->flags);
>>> +	}
>>> +
>>> +	mutex_unlock(&pwm->lock);
>>> +
>>> +	return err;
>>>  }
>>>  EXPORT_SYMBOL_GPL(pwm_enable);
>>
>> I meant to add the mutex check in disable also, but what about when
>> PWMF_ENABLED is checked in pwm_set_polarity() and pwm_dbg_show()?
> 
> I think for debugfs we're fine since there's no potential to race there.
> It'll simply show the state of the PWM at the point where it was queried
> even though that may change immediately after. I suppose we could keep
> the lock across the body of the loop just to make sure debugfs will show
> a consistent view of the PWM.
> 
> For pwm_disable() I don't think we need the lock, since the test_and_
> clear_bit() is atomic and ->disable() cannot fail.
> 
> As for pwm_set_polarity(), I think it would need to be something like
> the below:
> 
> ---- >8 ----
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 3f9df3ea3350..8488c7a19bf6 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -473,16 +473,22 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
>         if (!pwm->chip->ops->set_polarity)
>                 return -ENOSYS;
>  
> -       if (pwm_is_enabled(pwm))
> -               return -EBUSY;
> +       mutex_lock(&pwm->lock);
> +
> +       if (pwm_is_enabled(pwm)) {
> +               err = -EBUSY;
> +               goto unlock;
> +       }
>  
>         err = pwm->chip->ops->set_polarity(pwm->chip, pwm, polarity);
>         if (err)
> -               return err;
> +               goto unlock;
>  
>         pwm->polarity = polarity;
>  
> -       return 0;
> +unlock:
> +       mutex_unlock(&pwm->lock);
> +       return err;
>  }
>  EXPORT_SYMBOL_GPL(pwm_set_polarity);
>  
> 

Thierry,

Sounds good to me. I'll send a patch out for this hopefully today. I
don't see a need to complicate debugfs with obscure functionality so the
patch will just add polarity as you have shown it here and the enable
routine as the previous patchset.

Jon
