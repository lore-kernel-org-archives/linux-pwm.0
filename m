From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Subject: Re: [PATCH v2 2/2] pwm: send a uevent on the pwmchip device upon
 channel sysfs (un)export
Date: Mon, 1 Oct 2018 18:29:25 +0200
Message-ID: <b43c5dd5-6ffd-5e5a-f4d0-86792feac304@ysoft.com>
References: <1538400237-28766-1-git-send-email-fabrice.gasnier@st.com>
 <1538400237-28766-3-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1538400237-28766-3-git-send-email-fabrice.gasnier@st.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>, thierry.reding@gmail.com, gottfried.haider@gmail.com
Cc: stefan.wahren@i2se.com, linux-pwm@vger.kernel.org, loic.pallardy@st.com, linux-kernel@vger.kernel.org, hsweeten@visionengravers.com, broonie@kernel.org, linux-rpi-kernel@lists.infradead.org, gohai@sukzessiv.net, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

T24gMS4xMC4yMDE4IDE1OjIzLCBGYWJyaWNlIEdhc25pZXIgd3JvdGU6Cj4gVGhpcyBwYXRjaCBz
ZW5kcyBhIHVldmVudCAoS09CSl9DSEFOR0UpIG9uIHRoZSBwd21jaGlwTiBkZXZpY2UsIGV2ZXJ5
dGltZQo+IGEgcHdtWCBjaGFubmVsIGhhcyBiZWVuIGV4cG9ydGVkL3VuZXhwb3J0ZWQgdmlhIHN5
c2ZzLgo+IFRoaXMgYWxsb3dzIHVkZXYgdG8gaW1wbGVtZW50IHJ1bGVzIG9uIHN1Y2ggZXZlbnRz
LCBsaWtlOgo+IAo+IFNVQlNZU1RFTT09InB3bSoiLCBQUk9HUkFNPSIvYmluL3NoIC1jICdcCj4g
ICAgICAgICAgY2hvd24gLVIgcm9vdDpncGlvIC9zeXMvY2xhc3MvcHdtICYmIGNobW9kIC1SIDc3
MCAvc3lzL2NsYXNzL3B3bTtcCj4gICAgICAgICAgY2hvd24gLVIgcm9vdDpncGlvCj4gL3N5cy9k
ZXZpY2VzL3BsYXRmb3JtL3NvYy8qLnB3bS9wd20vcHdtY2hpcCogJiYgY2htb2QgLVIgNzcwCj4g
L3N5cy9kZXZpY2VzL3BsYXRmb3JtL3NvYy8qLnB3bS9wd20vcHdtY2hpcCpcCj4gJyIKPiAKPiBU
aGlzIGlzIGEgcmVwbGFjZW1lbnQgcGF0Y2ggZm9yIGNvbW1pdCA3ZTVkMWZkNzVjM2QgKCJwd206
IFNldCBjbGFzcyBmb3IKPiBleHBvcnRlZCBjaGFubmVscyBpbiBzeXNmcyIpLCBzZWUgWzFdLgo+
IAo+IGJhc2ljIHRlc3Rpbmc6Cj4gJCB1ZGV2YWRtIG1vbml0b3IgLS1lbnZpcm9ubWVudCAmCj4g
JCBlY2hvIDAgPiAvc3lzL2NsYXNzL3B3bS9wd21jaGlwMC9leHBvcnQKPiBLRVJORUxbMTk3LjMy
MTczNl0gY2hhbmdlICAgL2RldmljZXMvLi4uL3B3bS9wd21jaGlwMCAocHdtKQo+IEFDVElPTj1j
aGFuZ2UKPiBERVZQQVRIPS9kZXZpY2VzLy4uLi9wd20vcHdtY2hpcDAKPiBFWFBPUlQ9cHdtMAo+
IFNFUU5VTT0yMDQ1Cj4gU1VCU1lTVEVNPXB3bQo+IAo+IFsxXSBodHRwczovL2xrbWwub3JnL2xr
bWwvMjAxOC85LzI1LzcxMwo+IAo+IFNpZ25lZC1vZmYtYnk6IEZhYnJpY2UgR2FzbmllciA8ZmFi
cmljZS5nYXNuaWVyQHN0LmNvbT4KPiBUZXN0ZWQtYnk6IEdvdHRmcmllZCBIYWlkZXIgPGdvdHRm
cmllZC5oYWlkZXJAZ21haWwuY29tPgoKVGVzdGVkLWJ5OiBNaWNoYWwgVm9rw6HEjSA8bWljaGFs
LnZva2FjQHlzb2Z0LmNvbT4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
