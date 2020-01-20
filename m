From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: remove set but not set variable 'pwm'
Date: Mon, 20 Jan 2020 12:48:32 +0100
Message-ID: <20200120114832.uqa4dthodltu6xdv@pengutronix.de>
References: <20200119122202.14502-1-yukuai3@huawei.com>
 <20200120073407.ck2fmk7qdvqsfqsy@pengutronix.de>
 <55871ad5-4cb0-f3c8-a408-2c1be894126a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55871ad5-4cb0-f3c8-a408-2c1be894126a@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "yukuai (C)" <yukuai3@huawei.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, zhengbin13@huawei.com, yi.zhang@huawei.com
List-Id: linux-pwm@vger.kernel.org

On Mon, Jan 20, 2020 at 07:40:37PM +0800, yukuai (C) wrote:
> On 2020/1/20 15:34, Uwe Kleine-König wrote:
> > Fixes: e926b12c611c ("pwm: Clear chip_data in pwm_put()")
> 
> Thank you for your advise! I'll add 'Fixes' in a V2 patch.
> 
> > Did you check that dropping the locking is save? (I didn't)
> > 
> > I'd assume that no harm is introduced, but mentioning that in the commit
> > log would be good.
> 
> I think dropping the lock is safe since there is nothing to be done
> inside the lock. However, I didn't run a full test. By the way, I'll
> mentioning it in a V2 patch.

There are (rare) situations where taking and dropping a lock might make
sense. For example if you have a another context and want to make sure
that a shared resource isn't about to be used.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
