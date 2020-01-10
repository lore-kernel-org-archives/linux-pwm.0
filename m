From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH -next] pwm: sun4i: Fix wrong pointer passed to PTR_ERR()
Date: Fri, 10 Jan 2020 08:16:26 +0100
Message-ID: <20200110071626.5xmthg43j24p5ha2@pengutronix.de>
References: <20200110012515.32965-1-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200110012515.32965-1-weiyongjun1@huawei.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: thierry.reding@gmail.com, mripard@kernel.org, wens@csie.org, p.zabel@pengutronix.de, Jernej Skrabec <jernej.skrabec@siol.net>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Fri, Jan 10, 2020 at 01:25:15AM +0000, Wei Yongjun wrote:
> PTR_ERR should access the value just tested by IS_ERR, otherwise
> the wrong error code will be returned.
> 
> Fixes: 5b090b430d75 ("pwm: sun4i: Add an optional probe for bus clock")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

there is already a patch, see

	https://patchwork.ozlabs.org/patch/1220206/

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
