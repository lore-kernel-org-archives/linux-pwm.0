From: Jitao Shi <jitao.shi@mediatek.com>
Subject: Re: [PATCH v3 0/2] clocks don't disable when pwm_mtk_disp suspend
Date: Tue, 17 Dec 2019 11:56:28 +0800
Message-ID: <1576554988.19567.3.camel@mszsdaap41>
References: <20191217030438.26657-1-jitao.shi@mediatek.com>
 <CAGb2v65v+W3-fNwiC_0uN2RpFUBRu3iL2t+OaGHLjVHHWFJVwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGb2v65v+W3-fNwiC_0uN2RpFUBRu3iL2t+OaGHLjVHHWFJVwQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, CK Hu <ck.hu@mediatek.com>, sj.huang@mediatek.com, Thierry Reding <thierry.reding@gmail.com>, "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

On Tue, 2019-12-17 at 11:26 +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Tue, Dec 17, 2019 at 11:08 AM Jitao Shi <jitao.shi@mediatek.com> wrote:
> >
> > Changes since to v2:
> >  - Edit commit msg.
> >
> > Changes since to v1:
> >  - Edit commit msg.
> >  - Remove the register trigger in probe.
> >  - Rebase to v5.5-rc1.
> >
> > Changes in patches:
> >  - match pwm_mtk_disp clock when suspend/resume
> >  - trigger pwm_mtk_disp reg working after config
> >
> > Jitao Shi (2):
> >   pwm: fix pwm clocks not poweroff when disable pwm
> >   pwm: keep the trigger register after pwm setting.
> 
> Please add appropriate tags to your patches. These are not generic pwm
> patches, but are specific to one driver.
> 
> Consider the prefix: "pwm: mtk-disp: " so others can filter out the
> noise without looking at the content.
> 
> ChenYu

OK. I'll fix this prefix.

Best Regards
Jitao
> 
> >
> >  drivers/pwm/pwm-mtk-disp.c | 63 ++++++++++++--------------------------
> >  1 file changed, 19 insertions(+), 44 deletions(-)
> >
> > --
> > 2.21.0
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
