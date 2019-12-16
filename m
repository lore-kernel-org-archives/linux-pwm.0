From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 2/2] pwm/mtk_disp: move the reg enable trigger in
 config
Date: Mon, 16 Dec 2019 09:20:58 +0100
Message-ID: <20191216082058.xisbafewfttpkij6@pengutronix.de>
References: <20191216070123.114719-1-jitao.shi@mediatek.com>
 <20191216070123.114719-3-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191216070123.114719-3-jitao.shi@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jitao Shi <jitao.shi@mediatek.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, CK Hu <ck.hu@mediatek.com>, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, sj.huang@mediatek.com
List-Id: linux-pwm@vger.kernel.org

On Mon, Dec 16, 2019 at 03:01:23PM +0800, Jitao Shi wrote:
> Remove the regist enable trigger setting in probe.
> Move the trigger to mtk_disp_pwm_config().

Same as in patch 1: You describe what is (somewhat) obvious when reading
the patch. But the motivation isn't clear.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
