From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/2] pwm: fine tune pwm-mtk-disp clock control flow
Date: Mon, 16 Dec 2019 09:18:43 +0100
Message-ID: <20191216081843.yxe3vm674jwurwri@pengutronix.de>
References: <20191216070123.114719-1-jitao.shi@mediatek.com>
 <20191216070123.114719-2-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191216070123.114719-2-jitao.shi@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jitao Shi <jitao.shi@mediatek.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, CK Hu <ck.hu@mediatek.com>, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, sj.huang@mediatek.com
List-Id: linux-pwm@vger.kernel.org

Hello,

On Mon, Dec 16, 2019 at 03:01:22PM +0800, Jitao Shi wrote:
> Match pwm clock when suspend and resume.
> Prepare and enable disp_pwm clock when disp_pwm enable.
> Disable and unprepare disp_pwm clock when disp_pwm disable.

Assuming you catched all clock operations (I didn't check), the patch
looks fine. The commit log could however be improved. Additional to
describing what the patch does, some words about the motivation would be
good. Does this fix a bug? Is it to save some power while the PWM isn't
in use?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
