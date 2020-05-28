From: "Tanwar, Rahul" <rahul.tanwar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 2/2] Add PWM driver for LGM
Date: Thu, 28 May 2020 13:45:19 +0800
Message-ID: <42553091-1ce0-e7b8-b61b-eca5d723bb32@linux.intel.com>
References: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
 <3c1d2343b034325dbc185ccd23a35b40a62a4e7b.1590132733.git.rahul.tanwar@linux.intel.com>
 <20200522085613.ktb2ruw2virj337v@pengutronix.de>
 <3a1f1e83-2d9d-ddbf-e2e6-9c8bab87372b@linux.intel.com>
 <20200527091521.GH1634618@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200527091521.GH1634618-XvqNBM/wLWRrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, songjun.Wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


On 27/5/2020 5:15 pm, Andy Shevchenko wrote:
> On Wed, May 27, 2020 at 02:28:53PM +0800, Tanwar, Rahul wrote:
>> On 22/5/2020 4:56 pm, Uwe Kleine-König wrote:
>>> On Fri, May 22, 2020 at 03:41:59PM +0800, Rahul Tanwar wrote:
> ...
>
>>> I'm a unhappy to have this in the PWM driver. The PWM driver is supposed
>>> to be generic and I think this belongs into a dedicated driver.
>> Well noted about all other review concerns. I will rework the driver in v2.
>> However, i am not very sure about the above point - of having a separate
>> dedicated driver for tach_work because its logic is tightly coupled with
>> this driver.
> Actually I agree with Uwe.
> Here is layering violation, i.e. provider and consumer in the same pot. It's
> not good from design perspective.
>

Just to clarify, the PWM controller in our SoC serves just one purpose which
is to control the fan. Its actually named as PWM Fan Controller. There is no
other generic usage or any other consumer for this PWM driver. So separating
out this part seems redundant to me. Also, if we separate it out as a
dedicated driver, this will endup as a very small daemon which is going to be
very hard to justify while upstreaming..

Regards,
Rahul 
