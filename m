From: "David.Wu" <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v2 3/7] pwm: rockchip: Remove the dumplicate
 rockchip_pwm_ops ops
Date: Wed, 2 Aug 2017 19:31:57 +0800
Message-ID: <af056420-5c33-e6c8-62cb-bcd3456000a7@rock-chips.com>
References: <1499486629-9659-1-git-send-email-david.wu@rock-chips.com>
 <1499486629-9659-4-git-send-email-david.wu@rock-chips.com>
 <20170802105902.2d137072@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170802105902.2d137072@bbrezillon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hi Boris,

ÔÚ 2017/8/2 16:59, Boris Brezillon Ð´µÀ:
> Actually, when I suggested to just implement ->apply_state() and be
> done with all other fields I was thinking that you could get rid of
> this rockchip_pwm_data struct entirely and just have 3 different
> pwm_ops. You seem to take the other direction here: you're removing
> rockchip_pwm_ops_v1 and renaming rockchip_pwm_ops_v2 into
> rockchip_pwm_ops.

Yes, i really didn't understand exactly what you mean.
Your mean is that remove the set_enable, get_state and other hooks,
then use the pwm_ops instead of them, which has 3 different version, and 
implement the pwm_ops's functions like apply(), enable(), get_state() 
and others...?

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
