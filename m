From: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v1 2/2] Add PWM driver for LGM
Date: Wed, 27 May 2020 12:15:21 +0300
Message-ID: <20200527091521.GH1634618@smile.fi.intel.com>
References: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
 <3c1d2343b034325dbc185ccd23a35b40a62a4e7b.1590132733.git.rahul.tanwar@linux.intel.com>
 <20200522085613.ktb2ruw2virj337v@pengutronix.de>
 <3a1f1e83-2d9d-ddbf-e2e6-9c8bab87372b@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3a1f1e83-2d9d-ddbf-e2e6-9c8bab87372b@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, thierry.reding@gmail.com, p.zabel@pengutronix.de, linux-pwm@vger.kernel.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, songjun.Wu@intel.com, cheol.yong.kim@intel.com, qi-ming.wu@intel.com
List-Id: linux-pwm@vger.kernel.org

On Wed, May 27, 2020 at 02:28:53PM +0800, Tanwar, Rahul wrote:
> On 22/5/2020 4:56 pm, Uwe Kleine-König wrote:
> > On Fri, May 22, 2020 at 03:41:59PM +0800, Rahul Tanwar wrote:

...

> > I'm a unhappy to have this in the PWM driver. The PWM driver is supposed
> > to be generic and I think this belongs into a dedicated driver.
> 
> Well noted about all other review concerns. I will rework the driver in v2.
> However, i am not very sure about the above point - of having a separate
> dedicated driver for tach_work because its logic is tightly coupled with
> this driver.

Actually I agree with Uwe.
Here is layering violation, i.e. provider and consumer in the same pot. It's
not good from design perspective.

-- 
With Best Regards,
Andy Shevchenko
