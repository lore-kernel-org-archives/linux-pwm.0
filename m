From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH v3 3/3] pwm: core: add consumer device link
Date: Thu, 14 Feb 2019 11:30:26 +0100
Message-ID: <410eb559-fa7d-0eae-5666-328f09b483da@st.com>
References: <1550055012-23348-1-git-send-email-fabrice.gasnier@st.com>
 <1550055012-23348-4-git-send-email-fabrice.gasnier@st.com>
 <20190213125353.GI647@ulmo> <dc7396d4-d458-0a19-b996-2e1fa41a2fb7@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <dc7396d4-d458-0a19-b996-2e1fa41a2fb7@st.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com, tduszyns@gmail.com, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, robh+dt@kernel.org, mcoquelin.stm32@gmail.com, u.kleine-koenig@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 2/13/19 4:17 PM, Fabrice Gasnier wrote:
> On 2/13/19 1:53 PM, Thierry Reding wrote:
>> On Wed, Feb 13, 2019 at 11:50:12AM +0100, Fabrice Gasnier wrote:
>>> Add a device link between the PWM consumer and the PWM provider. This
>>> enforces the PWM user to get suspended before the PWM provider. It
>>> allows proper synchronization of suspend/resume sequences: the PWM user
>>> is responsible for properly stopping PWM, before the provider gets
>>> suspended: see [1]. Add the device link in:
>>> - of_pwm_get()
>>> - pwm_get()
>>> - devm_ variants
>>> as it requires a reference to the device for the PWM consumer.
>>>
>>> [1] https://lkml.org/lkml/2019/2/5/770
>>>
>>> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>> ---
>>> Changes in v3:
>>> - add struct device to of_get_pwm() arguments to handle device link from
>>>   there.
>>> ---
>>>  drivers/pwm/core.c  | 14 +++++++++++---
>>>  include/linux/pwm.h |  6 ++++--
>>>  2 files changed, 15 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
>>> index 1581f6a..8cb5d4bc 100644
>>> --- a/drivers/pwm/core.c
>>> +++ b/drivers/pwm/core.c
>>> @@ -638,6 +638,7 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
>>>  
>>>  /**
>>>   * of_pwm_get() - request a PWM via the PWM framework
>>> + * @dev: device for PWM consumer
>>>   * @np: device node to get the PWM from
>>>   * @con_id: consumer name
>>>   *
>>> @@ -655,7 +656,8 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
>>>   * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
>>>   * error code on failure.
>>>   */
>>> -struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
>>> +struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
>>> +			      const char *con_id)
>>>  {
>>>  	struct pwm_device *pwm = NULL;
>>>  	struct of_phandle_args args;
>>> @@ -689,6 +691,9 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
>>>  	if (IS_ERR(pwm))
>>>  		goto put;
>>>  
>>> +	if (!device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
>>> +		pr_debug("%s(): device link not added\n", __func__);
>>
>> I think it's better to turn this into dev_dbg(dev, ...) and maybe
>> mention which supplier it failed to link to, something like:
>>
>> 	if (!device_link_add(...))
>> 		dev_dbg(dev, "failed to create device link to %s\n",
>> 			pwm->chip->dev);
> 
> Hi Thierry,
> 
> Thanks for reviewing.
> 
> I can update this: I used pr_debug() as there are pr_err() calls
> elsewhere in this routine.
> BTW, do you wish an additional patch to turn pr_err() into dev_err() in
> of_pwm_get()?
> 
>>
>> Also, I wonder if this should perhaps be dev_err(). Under what
>> circumstances does this fail?
> 
> Well, here is a comment from "device_link_add()" routine:
> "
> /*
>  * If the supplier has not been fully registered yet or there is a
>  * reverse dependency between the consumer and the supplier already in
>  * the graph, return NULL.
>  */
> "
> 
> => Here the PWM supplier is already registered. (It seems a probe defer
> can be returned few lines above otherwise.)
> 
> Other possibilities: kzalloc() failed, no consumer or supplier has been
> provided (or invalid flags, but this is hardcoded here.).
> 
> So, I see two case here:
> 1 - The caller provided a 'dev' for PWM consumer... So, NULL link is an
> error when consumer & supplier has been passed correctly.
> => I can add a check on 'dev' for PWM consumer and report an error here:
>    return -EINVAL
> 
> 2 - The caller can't provide a 'dev' for PWM consumer as you mention
> bellow: "to allow code to get at the PWM if they didn't have..."
> => We should probably add a dev_warn() here, with no error ?
> Please see here after.
> 
>>
>>> +
>>>  	/*
>>>  	 * If a consumer name was not given, try to look it up from the
>>>  	 * "pwm-names" property if it exists. Otherwise use the name of
>>> @@ -771,7 +776,7 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
>>>  
>>>  	/* look up via DT first */
>>>  	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
>>> -		return of_pwm_get(dev->of_node, con_id);
>>> +		return of_pwm_get(dev, dev->of_node, con_id);
>>>  
>>>  	/*
>>>  	 * We look up the provider in the static table typically provided by
>>> @@ -851,6 +856,9 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
>>>  	pwm->args.period = chosen->period;
>>>  	pwm->args.polarity = chosen->polarity;
>>>  
>>> +	if (!device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
>>> +		pr_debug("%s(): device link not added\n", __func__);
>>
>> Same here. Also: not sure if we really need to include __func__ in the
>> message.
>>
>>> +
>>>  	return pwm;
>>>  }
>>>  EXPORT_SYMBOL_GPL(pwm_get);
>>> @@ -939,7 +947,7 @@ struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
>>>  	if (!ptr)
>>>  		return ERR_PTR(-ENOMEM);
>>>  
>>> -	pwm = of_pwm_get(np, con_id);
>>> +	pwm = of_pwm_get(dev, np, con_id);
>>>  	if (!IS_ERR(pwm)) {
>>>  		*ptr = pwm;
>>>  		devres_add(dev, ptr);
>>> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
>>> index d5199b5..895e074 100644
>>> --- a/include/linux/pwm.h
>>> +++ b/include/linux/pwm.h
>>> @@ -406,7 +406,8 @@ struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
>>>  		const struct of_phandle_args *args);
>>>  
>>>  struct pwm_device *pwm_get(struct device *dev, const char *con_id);
>>> -struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id);
>>> +struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
>>> +			      const char *con_id);
>>
>> I'm slightly concerned about this. I think one of the reasons why this
>> was introduced was to allow code to get at the PWM if they didn't have
>> a struct device * available. However, it doesn't seem like there are any
>> users of that function, so this seems fine.
> 
> The git blame pointed out commit 8eb961279960:
> "
> pwm: core: Rename of_pwm_request() to of_pwm_get() and export it
> 
> Allow client driver to use of_pwm_get() to get the PWM they need. This
> is needed for drivers which handle more than one PWM separately, like
> leds-pwm driver, which have:
> "
> ...
> 
> For instance, I tested the leds-pwm driver. It uses the devm_* variant
> now (as others), there is a struct device * available. So yes, it seems
> fine.
> 
> The only thing maybe out of tree code? This is where I have a doubt on
> having a mandatory struct device * to enforce consumer link creation...
> or make it optional (e.g. behave as a 'legacy' API) and warn the caller.
> 
> Please let me know your feeling.

Hi Thierry,

I just sent a v4 to update the error handling following the cases
described above.

BR,
Fabrice
> Best regards,
> Fabrice
> 
>>
>> Thierry
>>
>>>  void pwm_put(struct pwm_device *pwm);
>>>  
>>>  struct pwm_device *devm_pwm_get(struct device *dev, const char *con_id);
>>> @@ -494,7 +495,8 @@ static inline struct pwm_device *pwm_get(struct device *dev,
>>>  	return ERR_PTR(-ENODEV);
>>>  }
>>>  
>>> -static inline struct pwm_device *of_pwm_get(struct device_node *np,
>>> +static inline struct pwm_device *of_pwm_get(struct device *dev,
>>> +					    struct device_node *np,
>>>  					    const char *con_id)
>>>  {
>>>  	return ERR_PTR(-ENODEV);
>>> -- 
>>> 1.9.1
>>>
