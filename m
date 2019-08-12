From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: display: mediatek: update dpi
  supported chips
Date: Mon, 12 Aug 2019 15:51:03 -0600
Message-ID: <20190812215103.GB5954@bogus>
References: <20190807060257.57007-1-jitao.shi@mediatek.com>
 <20190807060257.57007-2-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190807060257.57007-2-jitao.shi@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jitao Shi <jitao.shi@mediatek.com>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <treding@nvidia.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, Inki Dae <inki.dae@samsung.com>, Rahul Sharma <rahul.sharma@samsung.com>, Sean Paul <seanpaul@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Andy Yan <andy.yan@rock-chips.com>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
List-Id: linux-pwm@vger.kernel.org

On Wed, Aug 07, 2019 at 02:02:54PM +0800, Jitao Shi wrote:
> Add decriptions about supported chips, including MT2701 & MT8173 &
> mt8183
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../bindings/display/mediatek/mediatek,dpi.txt        | 11 +++++++++++
>  1 file changed, 11 insertions(+)

And run a current get_maintainers.pl. Your DT maintainer list is out of 
date by years.

Rob
