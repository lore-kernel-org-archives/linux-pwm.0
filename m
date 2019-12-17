From: Chen-Yu Tsai <wens@kernel.org>
Subject: Re: [PATCH v3 0/2] clocks don't disable when pwm_mtk_disp suspend
Date: Tue, 17 Dec 2019 11:26:02 +0800
Message-ID: <CAGb2v65v+W3-fNwiC_0uN2RpFUBRu3iL2t+OaGHLjVHHWFJVwQ@mail.gmail.com>
References: <20191217030438.26657-1-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191217030438.26657-1-jitao.shi@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jitao Shi <jitao.shi@mediatek.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, CK Hu <ck.hu@mediatek.com>, sj.huang@mediatek.com, "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

Hi,

On Tue, Dec 17, 2019 at 11:08 AM Jitao Shi <jitao.shi@mediatek.com> wrote:
>
> Changes since to v2:
>  - Edit commit msg.
>
> Changes since to v1:
>  - Edit commit msg.
>  - Remove the register trigger in probe.
>  - Rebase to v5.5-rc1.
>
> Changes in patches:
>  - match pwm_mtk_disp clock when suspend/resume
>  - trigger pwm_mtk_disp reg working after config
>
> Jitao Shi (2):
>   pwm: fix pwm clocks not poweroff when disable pwm
>   pwm: keep the trigger register after pwm setting.

Please add appropriate tags to your patches. These are not generic pwm
patches, but are specific to one driver.

Consider the prefix: "pwm: mtk-disp: " so others can filter out the
noise without looking at the content.

ChenYu

>
>  drivers/pwm/pwm-mtk-disp.c | 63 ++++++++++++--------------------------
>  1 file changed, 19 insertions(+), 44 deletions(-)
>
> --
> 2.21.0
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
