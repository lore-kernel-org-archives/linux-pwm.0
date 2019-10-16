Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53232 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392341AbfJPKUY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 06:20:24 -0400
References: <20191016073842.1300297-1-thierry.reding@gmail.com>
 <20191016073842.1300297-3-thierry.reding@gmail.com>
 <20191016083107.fetprdj7k52hkdvy@pengutronix.de>
 <20191016095042.GB1303817@ulmo>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <ebb69ed6-8565-9b55-c66d-5a5cc9a9622f@st.com>
Date: Wed, 16 Oct 2019 12:20:17 +0200
MIME-Version: 1.0
In-Reply-To: <20191016095042.GB1303817@ulmo>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 2/3] pwm: stm32: Remove confusing bitmask
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org

On 10/16/19 11:50 AM, Thierry Reding wrote:
> On Wed, Oct 16, 2019 at 10:31:07AM +0200, Uwe Kleine-König wrote:
>> On Wed, Oct 16, 2019 at 09:38:41AM +0200, Thierry Reding wrote:
>>> Both BKP bits are set in the BDTR register and the code relies on the
>>> mask used during write to make sure only one of them is written. Since
>>> this isn't immediately obvious, a comment is needed to explain it. The
>>> same can be achieved by making explicit what happens, so add another
>>> temporary variable that contains only the one bit that is actually ORed
>>> into the register and get rid of the comment.
>>>
>>> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
>>> ---
>>>  drivers/pwm/pwm-stm32.c | 10 ++++------
>>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
>>> index b12fb11b7a55..8f1f3371e1dd 100644
>>> --- a/drivers/pwm/pwm-stm32.c
>>> +++ b/drivers/pwm/pwm-stm32.c
>>> @@ -493,26 +493,24 @@ static const struct pwm_ops stm32pwm_ops = {
>>>  static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
>>>  				    int index, int level, int filter)
>>>  {
>>> -	u32 bke, shift, mask, bdtr;
>>> +	u32 bke, bkp, shift, mask, bdtr;
>>>  
>>>  	if (index == 0) {
>>>  		bke = TIM_BDTR_BKE;
>>> +		bkp = TIM_BDTR_BKP;
>>>  		shift = TIM_BDTR_BKF_SHIFT;
>>>  		mask = TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_BDTR_BKF;
>>>  	} else {
>>>  		bke = TIM_BDTR_BK2E;
>>> +		bkp = TIM_BDTR_BK2P;
>>>  		shift = TIM_BDTR_BK2F_SHIFT;
>>>  		mask = TIM_BDTR_BK2E | TIM_BDTR_BK2P | TIM_BDTR_BK2F;
>>
>> Assuming in the else branch index is always 1, the following would be
>> IMHO nicer:
>>
>> #define TIM_BDTR_BKE(i) BIT(12 + 12 * (i))
>> #define TIM_BDTR_BKP(i) BIT(13 + 12 * (i))
>> #define TIM_BDTR_BKF_SHIFT(i) (16 + 4 * (i))
>>
>> ..
>>
>> 	bke = TIM_BDTR_BKE(index);
>> 	bkp = TIM_BDTR_BKP(index);
> 
> I had thought about that, but ultimately decided against it because
> the original defines might match exactly what's in the datasheet, so
> there's some value to keep the originals.
> 
> I suppose one other alternative would be to let the macros be and do the
> computations in the driver instead, something like:
> 
> 	bke = TIM_BDTR_BKE << (index * 12);
> 	bkp = TIM_BDTR_BKP << (index * 12);
> 	bkf = TIM_BDTR_BKF << (index *  4);
> 
> But yeah, I agree that having the parameters be part of the macros is
> even better.
> 
> Fabrice, any objection to redefining the macros as above?

Hi Thierry,

No objection from me, it will probably improve readability.

I'd just suggest an alternative to this: maybe a simple struct array
with two entries can improve readability ? E.g. keep the defines
matching the datasheet, and get rid of the conditional code ?

Dirty proposal:

static const struct stm32_pwm_brk[] = {
	/* {bke, bkp, shift, mask} */
	{ TIM_BDTR_BKE, TIM_BDTR_BKP, ...},
	{ TIM_BDTR_BK2E, TIM_BDTR_BK2P, ...},
}

and use "index" to index it ?

But I'm fine with the macros as well: there's already similar things in
this driver to deal with the channels for instance.

Thanks,
Fabrice
> 
> Thierry
> 
