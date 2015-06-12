From: Jonathan Richardson <jonathar@broadcom.com>
Subject: Re: [PATCH v8 5/5] pwm: core: Set enable state properly on failed
 call to enable
Date: Fri, 12 Jun 2015 12:22:29 -0700
Message-ID: <557B3175.4020600@broadcom.com>
References: <1432670900-27687-1-git-send-email-jonathar@broadcom.com> <1432670900-27687-6-git-send-email-jonathar@broadcom.com> <20150612094937.GE19400@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:52351 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbbFLTWt (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Jun 2015 15:22:49 -0400
In-Reply-To: <20150612094937.GE19400@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Tim Kryger <tim.kryger@gmail.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

On 15-06-12 02:49 AM, Thierry Reding wrote:
> On Tue, May 26, 2015 at 01:08:20PM -0700, Jonathan Richardson wrote:
>> The pwm_enable function didn't clear the enabled bit if a call to a
>> clients enable function returned an error. The result was that the state
>> of the pwm core was wrong. Clearing the bit when enable returns an error
>> ensures the state is properly set.
>>
>> Tested-by: Jonathan Richardson <jonathar@broadcom.com>
>> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
>> ---
>>  drivers/pwm/core.c |   16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
>> index 224645f..18f5ac4 100644
>> --- a/drivers/pwm/core.c
>> +++ b/drivers/pwm/core.c
>> @@ -477,10 +477,20 @@ EXPORT_SYMBOL_GPL(pwm_set_polarity);
>>   */
>>  int pwm_enable(struct pwm_device *pwm)
>>  {
>> -	if (pwm && !test_and_set_bit(PWMF_ENABLED, &pwm->flags))
>> -		return pwm->chip->ops->enable(pwm->chip, pwm);
>> +	int err;
>> +
>> +	if (!pwm)
>> +		return -EINVAL;
>> +
>> +	if (!test_and_set_bit(PWMF_ENABLED, &pwm->flags)) {
>> +		err = pwm->chip->ops->enable(pwm->chip, pwm);
>> +		if (err) {
>> +			clear_bit(PWMF_ENABLED, &pwm->flags);
>> +			return err;
>> +		}
>> +	}
> 
> I think with this new pattern we're now actually going to need a lock to
> make sure pwm->flags doesn't change between the test_and_set_bit() and
> clear_bit() calls.
> 
> Thierry
> 

Ok. I'll add a lock per pwm_device and re-send the patch.

Jon
