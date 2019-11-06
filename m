From: Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [PATCH 1/4] dt-bindings: counter: Convert stm32 counter bindings
 to json-schema
Date: Wed, 6 Nov 2019 19:58:08 +0000
Message-ID: <29d97cd1-4dc2-24a1-182f-d1bf6956ee5b@st.com>
References: <20191031123040.26316-1-benjamin.gaignard@st.com>
 <20191031123040.26316-2-benjamin.gaignard@st.com>
 <20191106041023.GB5294@bogus> <20191106041608.GA24747@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191106041608.GA24747@bogus>
Content-Language: en-US
Content-ID: <9AC39F460CE5B44394ED8C7013DF655A@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "lars@metafoo.de" <lars@metafoo.de>, Alexandre TORGUE <alexandre.torgue@st.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "knaack.h@gmx.de" <knaack.h@gmx.de>, Fabrice GASNIER <fabrice.gasnier@st.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "jic23@kernel.org" <jic23@kernel.org>
List-Id: linux-pwm@vger.kernel.org


On 11/6/19 5:16 AM, Rob Herring wrote:
> On Tue, Nov 05, 2019 at 10:10:23PM -0600, Rob Herring wrote:
>> On Thu, Oct 31, 2019 at 01:30:37PM +0100, Benjamin Gaignard wrote:
>>> Convert the STM32 counter binding to DT schema format using json-schema
>> Probably this should all be 1 file instead.
> Also, checkpatch reports trailing whitespace in several of your patches.

I will write all in one file and fix trailing whitespace in v2

Thanks for your review

Benjamin

> .
>
> Rob
