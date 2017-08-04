From: "David.Wu" <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v2 3/7] pwm: rockchip: Remove the dumplicate
 rockchip_pwm_ops ops
Date: Fri, 4 Aug 2017 10:38:26 +0800
Message-ID: <6d1f60ee-2402-5ee0-54f6-9521c039c36c@rock-chips.com>
References: <1499486629-9659-1-git-send-email-david.wu@rock-chips.com>
 <1499486629-9659-4-git-send-email-david.wu@rock-chips.com>
 <20170802105902.2d137072@bbrezillon>
 <af056420-5c33-e6c8-62cb-bcd3456000a7@rock-chips.com>
 <20170802134011.1124f1dd@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170802134011.1124f1dd@bbrezillon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hi Boris，

在 2017/8/2 19:40, Boris Brezillon 写道:
> Yep, just define 3 different pwm_ops (one for each IP), each of them
> implementing ->apply() and ->get_state() and that's all.
> 
> Something like:
> 
> static const struct pwm_ops rockchip_pwm_ops_v1 = {
> 	.get_state = rockchip_pwm_v1_get_state,
> 	.apply = rockchip_pwm_v1_apply,
> 	.owner = THIS_MODULE,
> };
> 
> static const struct pwm_ops rockchip_pwm_ops_v2 = {
> 	.get_state = rockchip_pwm_v2_get_state,
> 	.apply = rockchip_pwm_v2_apply,
> 	.owner = THIS_MODULE,
> };
> 
> static const struct pwm_ops rockchip_pwm_ops_vop = {
> 	.get_state = rockchip_pwm_vop_get_state,
> 	.apply = rockchip_pwm_vop_apply,
> 	.owner = THIS_MODULE,
> };
> 
> static const struct of_device_id rockchip_pwm_dt_ids[] = {
> 	{ .compatible = "rockchip,rk2928-pwm", .data = &rockchip_pwm_ops_v1 },
> 	{ .compatible = "rockchip,rk3288-pwm", .data = &rockchip_pwm_ops_v2 },
> 	{ .compatible = "rockchip,vop-pwm", .data = &rockchip_pwm_ops_vop },
> 	{ /* sentinel */ }
> };
> MODULE_DEVICE_TABLE(of, rockchip_pwm_dt_ids);

I think we should keep the data members in the rockchip_pwm_data，like 
supports_polarity and regs...

The supports_polarity is needed for of_pwm_n_cells when pwm registered.
And the other data members is helpful for us to use common code.

It's okay for just define 3 different pwm_ops (one for each IP), but 
they are with other data members in the struct of rockchip_pwm_data.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
