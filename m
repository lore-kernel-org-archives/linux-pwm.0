From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] pwm: sun4i: redundant assignment to variable pval
Date: Wed, 2 Oct 2019 14:30:29 +0100
Message-ID: <d67c2091-3029-1cf1-5548-b9f3116cd139@canonical.com>
References: <20191002100844.10490-1-colin.king@canonical.com>
 <20191002132506.GO22609@kadam> <20191002132933.GO29696@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191002132933.GO29696@kadam>
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
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 02/10/2019 14:29, Dan Carpenter wrote:
> On Wed, Oct 02, 2019 at 04:25:06PM +0300, Dan Carpenter wrote:
>> On Wed, Oct 02, 2019 at 11:08:44AM +0100, Colin King wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> Variable pval is being assigned a value that is never read. The
>>> assignment is redundant and hence can be removed.
>>>
>>> Addresses-Coverity: ("Unused value")
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>> ---
>>>  drivers/pwm/pwm-sun4i.c | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
>>> index 6f5840a1a82d..53970d4ba695 100644
>>> --- a/drivers/pwm/pwm-sun4i.c
>>> +++ b/drivers/pwm/pwm-sun4i.c
>>> @@ -156,7 +156,6 @@ static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
>>>  	if (sun4i_pwm->data->has_prescaler_bypass) {
>>>  		/* First, test without any prescaler when available */
>>>  		prescaler = PWM_PRESCAL_MASK;
>>> -		pval = 1;
>>>  		/*
>>>  		 * When not using any prescaler, the clock period in nanoseconds
>>>  		 * is not an integer so round it half up instead of
>>
>> Are you sure?  It looks used to me.
> 
> Ah.  Never mind.  My tree was out of date.

No problem. I appreciated you eyeballing my fixes.
> 
> regards,
> dan carpenter
> 
