From: "jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] This adds a generic PWM framework driver
 for the PWM controller
Date: Tue, 19 Aug 2014 08:38:21 -0400
Message-ID: <CAKON4OycUjDN-aPys-6hiFUHUdri12yE-=4J1LEAJVM1W3RD8A@mail.gmail.com>
References: <20140818180316.31807.3445.stgit@studio>
	<20140818192318.GJ15297@lukather>
	<CAKON4OwzFDDXqCF4VNkUXXJLp3smrB6Axp_x=D47sjbpoNbe+g@mail.gmail.com>
	<20140818201929.GL15297@lukather>
	<CAKON4OwDWqnu9Nn6rBFtUJX2f0eFVzBFhRMcvPAp=K6N1KpE0w@mail.gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBC55LFUF6ALBBPUKZWPQKGQE5HQJJ6A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAKON4OwDWqnu9Nn6rBFtUJX2f0eFVzBFhRMcvPAp=K6N1KpE0w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, ARM Linux Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Tue, Aug 19, 2014 at 8:11 AM, jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Mon, Aug 18, 2014 at 4:19 PM, Maxime Ripard
> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>> On Mon, Aug 18, 2014 at 03:53:08PM -0400, jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>>> On Mon, Aug 18, 2014 at 3:23 PM, Maxime Ripard
>>> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>>> > Hi,
>>> >
>>> > On Mon, Aug 18, 2014 at 02:03:16PM -0400, Jon Smirl wrote:
>>> >> found on Allwinner SoCs.x
>>> >>
>>> >> Signed-off-by: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> >
>>> > Is there any notable difference with Alexandre's driver?
>>> > https://lkml.org/lkml/2014/5/19/568
>>> >
>>> > If so, why didn't you posted incremental patches on top of his driver?
>>>
>>> Better A10 support.
>>
>> Better how?
>>
>>> And I wrote this one without know about his.
>>
>> So you're just require us to trash an already extensively reviewed
>> driver and start from scratch again?
>
> Forget mine then.
>
> Problems in the other one....
> 1) The math is not right in either patch. Selsinork has been checking
> mine with a scope and just found another math error in mine. The
> internal math needs to be done in picoseconds or round off errors mess
> up the high frequency outputs (24Mhz, 12Mhz, 8Mhz, ...).

Correct output table....
Neither driver has this right.

24Mhz  41.6ns period  1  - 62
12Mhz  83.3ns period 63 - 104
8Mhz  125ns  period 105 - 145
6Mhz  167ns period 146 - 187
4.8Mhz 208ns period 188 - 229
4Mhz   250ns period 230 - 270
3.4Mhz  292ns period 271 - 312
3Mhz   333ns  period 313 - 345




> 3) By-pass mode on the A20 is not implemented.
> 2) A10 is not correctly handled. Specifically the prescaler is
> different on the A10 vs A20.
>
>
>
>
>
>
>>
>> --
>> Maxime Ripard, Free Electrons
>> Embedded Linux, Kernel and Android engineering
>> http://free-electrons.com
>
>
>
> --
> Jon Smirl
> jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org



-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
