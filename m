From: "David.Wu" <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v3 2/7] pwm: rockchip: Remove the judge from return value
 of pwm_config
Date: Mon, 21 Aug 2017 19:29:00 +0800
Message-ID: <1f3bda8e-3130-efeb-92f4-f6c57944b1f3@rock-chips.com>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
 <1502206715-24174-3-git-send-email-david.wu@rock-chips.com>
 <20170818153255.GC18307@ulmo> <20170818162830.GA115593@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170818162830.GA115593-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

ÔÚ 2017/8/19 0:28, Brian Norris Ð´µÀ:
> On Fri, Aug 18, 2017 at 05:32:55PM +0200, Thierry Reding wrote:
>> I don't understand what the "judge" is supposed to be, but I've applied
>> this to for-4.14/drivers anyway. Thanks.
> 
> Probably just an artifact of non-native English.
> 
> Judging by context, David probably meant more like "Remove the check for
> the return value". I believe I've seen other non-native English speakers
> use "judge" in a way similar to "check" or "test" in the context of
> comparisons and error checking. (A search through my mailbox for "judge"
> confirms this.)
> 

Yeap, as Brain said, the "Remove the check for the return value "will be 
better, the "judge" looks like a grammatical error here now.

> Regards,
> Brian
> 
> 
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
