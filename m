From: Claudiu Beznea <Claudiu.Beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH v2 10/16] pwm: Add PWM modes
Date: Mon, 22 Jan 2018 10:54:07 +0200
Message-ID: <c5aeb8df-6aa8-cde4-9305-08777cac2f45@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-11-git-send-email-claudiu.beznea@microchip.com>
 <20180119223452.doeqfd4aewkf5fla@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20180119223452.doeqfd4aewkf5fla@rob-hp-laptop>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org



On 20.01.2018 00:34, Rob Herring wrote:
> On Fri, Jan 12, 2018 at 04:22:57PM +0200, Claudiu Beznea wrote:
>> Define a macros for PWM modes to be used by device tree sources.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
>> ---
>>  include/dt-bindings/pwm/pwm.h | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
>> index ab9a077e3c7d..b8617431f8ec 100644
>> --- a/include/dt-bindings/pwm/pwm.h
>> +++ b/include/dt-bindings/pwm/pwm.h
>> @@ -12,4 +12,7 @@
>>  
>>  #define PWM_POLARITY_INVERTED			(1 << 0)
>>  
>> +#define PWM_DTMODE_NORMAL			(1 << 0)
> 
> Bit 0 is already taken. I think you mean (0 << 1)?
I wanted to have the PWM modes in a new cell, so that the pwms binding to be
something like:
pwms=<pwm-controller pwm-channel pwm-period pwm-flags pwm-mode>

If you think it is mode feasible to also include PWM mode in the cell for 
PWM flags, please let me know.

> 
> Personally, I'd just drop this define. A define for a 0 value makes more 
> sense when each state is equally used (like active high or low), but if 
> 0 is the more common case, then I don't the need for a define.
I want it to have these defines like bit defines:
PWM_DTMODE_NORMAL=0x1
PWM_DTMODE_COMPLEMENTARY=0x2
PWM_DTMODE_PUSH_PULL=0x4

Thank you,
Claudiu Beznea

> 
>> +#define PWM_DTMODE_COMPLEMENTARY		(1 << 1)
>> +
>>  #endif
>> -- 
>> 2.7.4
>>
> 
